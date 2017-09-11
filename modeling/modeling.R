# loop through combinations of design matrices and label matrices
# run a bunch of algorithms on the data
# store the results for analysis

# each docker container should do all modeling tasks for an x-y pair

# targets: 
#  classification (up / down from previous year?) 
#  regression (# of crashes)




##########################
## CREATE DATAFRAME OF MATRICES FOR TRAINING AND TESTING

for(i in 2011:2015){  # year of test set label
  i=2011
  
  
  ##########################
  ## PREP THE DATA
  
  # y test
  test_labels_query = paste(
    'select labels_csv_id' 
    ,'from matrices.labels as b'
    ,'where b.labels_start_year =', i
    ,'and b.labels_end_year =', i
  )
  test_labels_df = dbGetQuery(con, test_labels_query)
  y_test_raw = aws.s3::get_object(
    paste0('s3://transportation-safety-data/etl/label_files/' 
          ,test_labels_df[1,1]
          ,'.csv'
          )
  )
  y_test = read.csv(text = rawToChar(y_test_raw), row.names = 1)
  
  # y train
  train_labels_query = paste(
    'select labels_csv_id' 
    ,'from matrices.labels as b'
    ,'where b.labels_start_year <', i-1
  )
  train_labels_df = dbGetQuery(con, train_labels_query)
  y_train_raw = aws.s3::get_object(
    paste0('s3://transportation-safety-data/etl/label_files/' 
           ,train_labels_df[1,1]
           ,'.csv'
    )
  )
  y_train = read.csv(text = rawToChar(y_train_raw), row.names = 1)
  
  # x test
  test_features_query = paste(
    'select features_csv_id' 
    ,'from matrices.features as a'
    ,'where a.features_end_year = ', i-1  # predict 1 year ahead (can be loosened)
  )
  test_features_df = dbGetQuery(con, test_features_query)
  x_test_raw = aws.s3::get_object(
    paste0('s3://transportation-safety-data/etl/feature_files/' 
           ,test_features_df[1,1]
           ,'.csv'
    )
  )
  x_test = read.csv(text = rawToChar(x_test_raw), row.names = 1)
  
  # x train
  train_features_query = paste(
    'select features_csv_id' 
    ,'from matrices.features as a'
    ,'where a.features_end_year =', i
  )
  train_features_df = dbGetQuery(con, train_features_query)
  x_train_raw = aws.s3::get_object(
    paste0('s3://transportation-safety-data/etl/feature_files/' 
           ,train_features_df[1,1]
           ,'.csv'
    )
  )
  x_train = read.csv(text = rawToChar(x_train_raw), row.names = 1)
  
  train_df = merge(y_train, x_train, by = 'row.names')   
  
  
  
  
  ##########################
  ## DEFINE TASK
  task = makeRegrTask(id='regr', data=train_df, target=y)
  
  
  
  
  ##########################
  ## CREATE LEARNERS
  lrn.penalized = makeLearner('regr.penalized', par.vals=list())
  lrn.rf  = makeLearner('regr.randomForest', par.vals=list(n.trees=1000))
  
  
  
  ##########################
  ## TRAIN LEARNERS
  # store this info in the database
  
  set.seed(31415)
  mod.penalized = train(lrn.penalized, task)
  mod.rf = train(lrn.rf, task)
  
  
  ##########################
  ## TEST OUT OF SAMPLE
  # store predictions, labels in database
  predict.penalized = predict(mod.penalized, newdata=df_test)
  
  
  
  
}







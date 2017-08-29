# loop through combinations of design matrices and label matrices
# run a bunch of algorithms on the data
# store the results for analysis

# each docker container should do all modeling tasks for an x-y pair

# targets: 
#  classification (up / down from previous year?) 
#  regression (# of crashes)



##########################
## LOAD PACKAGES

require('mlr')




##########################
## PREP THE DATA
# join x & y into single dataframe

# train
#x_train = h5file('')
#y_train = h5file('')
#df_train = x_train + y_train

# test
#x_test = h5file('')
#y_test = h5file('')
#df_test = x_test + y_test



##########################
## DEFINE TASK

task = makeRegrTask(id='regr', data=df, target=y)




##########################
## CREATE LEARNERS

#lrn.penalized = makeLearner('regr.penalized', par.vals=list())
#lrn.rf  = makeLearner('regr.randomForest', par.vals=list(n.trees=1000))



##########################
## TRAIN LEARNERS
# store this info in the database

set.seed(31415)
#mod.penalized = train(lrn.penalized, task)
#mod.rf = train(lrn.rf, task)


##########################
## TEST OUT OF SAMPLE
# store predictions, labels in database
#predict.penalized = predict(mod.penalized, newdata=df_test)


# 1. Prep data
# 2. Create design matrices
# 3. Create label matrices




##########################
## FEATURES GENERATION

# function:
#   input:
#     raw_df
#     features_start_date
#     features_end_date
#     geographic_id
#     add columns of random data
#   output:
#     store as csv

create_features_df = function(
  raw_df = raw_data
  ,features_start_year = 2009
  ,features_end_year = 2011
  ,number_cols_random_data = 10
  ,features_list = ''
  ,comments = ''
  ){
  
  # subset by time
  raw_features_df = subset(
    raw_df
    ,subset = (Year >= features_start_year & Year <= features_end_year)
    ,select = c('County', 'Year')
  )
  
  # create features dataframe
  features_df = aggregate(
    raw_features_df
    ,list(county = raw_features_df$County, year = raw_features_df$Year)
    ,FUN = length
  )
  rownames(features_df) = paste(features_df$county, features_df$year, sep='_')
  features_df = subset(features_df, select = 3)
  names(features_df) = 'crashes'
  n = nrow(features_df)
  
  
  ### ADD FEATURES
  random_df = data.frame( replicate( number_cols_random_data, rnorm(n) ) )
  features_df = cbind(features_df, random_df)
  
    
  
  
  
  ### STORE FEATURES INFO
  
  # create unique identifier
  uuid = UUIDgenerate(use.time = FALSE)
  
  # save feature names
  feature_names = paste( unlist( names(features_df) ), collapse=',')
  
  # write to database
  db_row = data.frame(
    features_csv_id = uuid
    ,features_start_year = features_start_year
    ,features_end_year = features_end_year
    ,features_list = feature_names
    ,comments = comments
    ,stringsAsFactors = FALSE
  )
  dbWriteTable(
    con
    ,c('matrices', 'features')
    ,db_row
    ,row.names = FALSE
    ,append = TRUE
  )
  
  
  # write to csv 
  csv_name = paste(
    uuid
    ,'csv'
    ,sep='.'
  ) 
  write.csv(
    features_df 
    ,paste('/tmp', csv_name, sep='/')
    ,row.names = TRUE
  )
  
  # store in s3
  
  aws.s3::put_object(
    file = paste('/tmp', csv_name, sep='/')
    ,object = paste('s3://transportation-safety-data/etl/feature_files', csv_name, sep='/')
  )
  
}


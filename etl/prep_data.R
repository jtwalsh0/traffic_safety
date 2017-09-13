

##########################
## LOAD DATA
raw_data = read.csv(
  '~/Dropbox/Machine Learning/CARE_sample_2009-2016.csv'
  ,stringsAsFactors = FALSE
)




##########################
## CREATE LABELS MATRICES

source ('etl/labels.R')

for(i in 2010:2016){  # years
  
  # test labels generation
  create_labels_df(
    raw_data
    ,labels_start_year = i 
    ,labels_end_year = i
  )
  
}




##########################
## FEATURES GENERATION

source('etl/features.R')

for(i in 2009:2016){  # years 
  for(j in 0:7){  # lookback years

    create_features_df(
      raw_data
      ,features_start_year = i-j
      ,features_end_year = i
      ,features_list = ''
      ,number_cols_random_data = 10
      ,comments = 'testing the code'
    )
    
  }
}




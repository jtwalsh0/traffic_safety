
require('uuid')
require('dplyr')
require('readr')


##########################
## LOAD DATA
raw_df = read_csv(care_data)



##########################
## CREATE LABELS MATRICES

source ('etl/labels.R')

for(i in 2010:2010){  # years
  
  i=2010
  # test labels generation
  create_labels_df(
    raw_df
    ,geography = 'County'
    ,labels_start_year = i
    ,labels_end_year = i
  )
  
}




##########################
## FEATURES GENERATION

source('etl/features.R')

for(i in 2009:2009){  # years
  for(j in 0:7){  # lookback years

    # only run if data are available for that time period
    beginning_of_time = min(raw_df$Year)
    if(i-j >= beginning_of_time){
      create_features_df(
        raw_df
        ,features_start_year = i-j
        ,features_end_year = i
        ,features_list = ''
        ,number_cols_random_data = 10
        ,comments = 'testing the code'
      )
    }

  }
}




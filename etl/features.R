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
  ,features_end_year = 2009
  ,number_cols_random_data = 10
  ,features_list = toString( sort( paste('random', 1:10, sep='_') ) )
  ,comments = ''
  ){
  
  
    # sort and stringify features 
    features_list_sorted = sort(features_list)
    features_list_sorted_string = toString(features_list_sorted)
  
    # check for existing features matrix
    raw_query = paste('select features_csv_id from matrices.features where'
                      ,'features_start_year = ?features_start_year'
                      ,'and features_end_year = ?features_end_year'
                      ,'and geography = ?geography'
                      ,'and features_list = ?features_list '
    )
    query = sqlInterpolate(ANSI()
                           ,raw_query
                           ,features_start_year = features_start_year
                           ,features_end_year = features_end_year
                           ,geography = geography
                           ,features_list = features_list_sorted_string
    )
    results = dbGetQuery(con, query)
    
  
    # only create CSV if it doesn't exist already  
    if(nrow(results) == 0){
    
      # subset by time and collapse to observational units
      features_df = raw_df %>%
        filter(Year >= get('features_start_year') & Year <= get('features_end_year')) %>%
        select(get('geography'), `Year`) %>%
        distinct()
  

      
      ###################################
      ### ADD FEATURES
      
      # add crash counts
      grep_crash_count = grep('crash_count', features_list, ignore.case=TRUE)
      if(length(grep_crash_count) > 0){
        crash_counts = raw_df %>%
          filter(Year >= get('features_start_year') & Year <= get('features_end_year')) %>%
          select(get('geography'), `Year`) %>%
          group_by_(get('geography'), 'Year') %>%
          summarize(`crash_count` = n())
        features_df = merge(features_df
                            ,crash_counts
                            ,by = c(get('geography'), 'Year')
                            ,all.x = TRUE  # left join
                            )
      }
      
      # add random features
      grep_random = grep('random', features_list, ignore.case=TRUE)
      if(length(grep_random) > 0){
        n = nrow(features_df)
        random_df = data.frame( replicate( number_cols_random_data, rnorm(n)))
        names(random_df) = paste('random', 1:number_cols_random_data, sep='_')
        features_df = cbind(features_df, random_df)
      }
        
      
      
      
      ###################################
      ### STORE FEATURES INFO
      
      # create unique identifier
      uuid = UUIDgenerate(use.time = TRUE)
      
      # save feature names
      feature_df_names = names(features_df)[-c(1,2)]
      feature_df_names_sorted = sort(feature_df_names)
      feature_df_names_sorted_string = toString(feature_df_names_sorted)
      
      # write to database
      db_row = data.frame(
        features_csv_id = uuid
        ,features_start_year = features_start_year
        ,features_end_year = features_end_year
        ,features_list = feature_df_names_sorted_string
        ,creation_time = Sys.time()
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
  
    } else{  # print uuid if CSV already exists
      
      print(paste('Features CSV already exists:', uuid)) 
    
    }  

}


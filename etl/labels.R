# 3. Create label matrices




##########################
## LABELS GENERATION

# function:
#   input:
#     labels_start_date
#     labels_end_date
#     geographic_id
#     rule to generate label (e.g. sum())
#   output:
#     store as csv

create_labels_df = function(
  raw_df = raw_data
  ,labels_start_year = 2010
  ,labels_end_year = 2010
  ,geography = 'County' # should match column name
  ,label_query = 'sum crash count' # this doesn't do anything yet
  ,comments = ''
  ){
  
    # check for existing label matrix
    raw_query = paste('select labels_csv_id from matrices.labels where'
                      ,'labels_start_year = ?labels_start_year'
                      ,'and labels_end_year = ?labels_end_year'
                      ,'and geography = ?geography'
                      ,'and label_query = ?label_query '
                      )
    query = sqlInterpolate(ANSI()
                           ,raw_query
                           ,labels_start_year = labels_start_year
                           ,labels_end_year = labels_end_year
                           ,geography = geography
                           ,label_query = label_query
                           )
    results = dbGetQuery(con, query)
    
    
    # if labels CSV doesn't exist, create it
    # otherwise, return the uuid for that CSV
    if(nrow(results) == 0){
      
      # subset by entity and time
      labels_df = raw_df %>%
        filter(Year >= get('labels_start_year') & Year <= get('labels_end_year')) %>%
        select(get('geography'), `Year`) %>%
        group_by_(get('geography'), 'Year') %>%
        summarize(`y` = n())
        
      # create unique identifier
      uuid = UUIDgenerate(use.time = TRUE)
      
      # write to database
      db_row = data.frame(
        labels_csv_id = uuid
        ,labels_start_year = labels_start_year
        ,labels_end_year = labels_end_year
        ,geography = geography
        ,label_query = label_query
        ,creation_time = Sys.time()
        ,comments = comments
        ,stringsAsFactors = FALSE
      )
      dbWriteTable(
        con
        ,c('matrices', 'labels')
        ,db_row
        ,row.names = FALSE
        ,append = TRUE
      )
      
    
      # write to csv 
      csv_name = paste(uuid, 'csv', sep='.') 
      write.csv(
        labels_df 
        ,paste('/tmp', csv_name, sep='/')
        ,row.names = FALSE
      )
      
      # store in s3
      aws.s3::put_object(
        file = paste('/tmp', csv_name, sep='/')
        ,object = paste('s3://transportation-safety-data/etl/label_files', csv_name, sep='/')
      )
      
    } else {
      print(paste('labels CSV already exists:', uuid))  # if the CSV already exists
    }
  
}



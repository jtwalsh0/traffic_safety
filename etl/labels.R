# 1. Prep data
# 2. Create design matrices
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
  ,labels_start_year = 2012
  ,labels_end_year = 2012
  ,label_query = 'all_crash_count'
  ,comments = ''
  ){
  
  # subset by entity and time
  raw_labels_df = subset(
    raw_df
    ,subset = (Year >= labels_start_year & Year <= labels_end_year)
    ,select = c('County', 'Year')
  )
  
  # create labels dataframe
  labels_df = aggregate(
    raw_labels_df
    ,list(County = raw_labels_df$County, Year = raw_labels_df$Year) 
    ,FUN = length
  )
  rownames(labels_df) = paste(labels_df$County, labels_df$Year, sep='_')
  labels_df = subset(labels_df, select = 3)
  names(labels_df) = 'y'
  
  # create unique identifier
  uuid = UUIDgenerate(use.time = FALSE)
  
  # write to database
  db_row = data.frame(
    labels_csv_id = uuid
    ,labels_start_year = labels_start_year
    ,labels_end_year = labels_end_year
    ,label_query = label_query
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
  csv_name = paste(
    uuid
    ,'csv'
    ,sep='.'
  ) 
  write.csv(
    labels_df 
    ,paste('/tmp', csv_name, sep='/')
    ,row.names = TRUE
  )
  
  # store in s3

  aws.s3::put_object(
    file = paste('/tmp', csv_name, sep='/')
    ,object = paste('s3://transportation-safety-data/etl/label_files', csv_name, sep='/')
  )
  
}



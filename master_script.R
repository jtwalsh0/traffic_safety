setwd('/Users/joewalsh/git-projects/traffic_safety/')



##########################
## LOAD PACKAGES

require('checkpoint')
checkpoint('2017-08-01')

require('plm')
require('mlr')
require('uuid')
require('jsonlite')
require('RPostgreSQL')




##########################
## CONNECT TO S3

aws_credentials = fromJSON('credentials.json')$aws
Sys.setenv(
  "AWS_ACCESS_KEY_ID" = aws_credentials$AWS_ACCESS_KEY_ID
  ,"AWS_SECRET_ACCESS_KEY" = aws_credentials$AWS_SECRET_ACCESS_KEY
  ,"AWS_DEFAULT_REGION" = "us-east-1"
)
           





##########################
## CONNECT TO DATABASE

# load credentials
db_credentials = fromJSON('credentials.json')$db

# creates a connection to the postgres database
con <- dbConnect(drv = dbDriver('PostgreSQL'),
                 host = db_credentials$PGHOST,
                 dbname = db_credentials$PGDATABASE,
                 user = db_credentials$PGUSER,
                 password = db_credentials$PGPASSWORD,
                 port = db_credentials$PGPORT)

# remove credentials
rm (db_credentials) 



##########################
## LOAD FUNCTIONS

source('etl/prep_data.R')
source('modeling/modeling.R')



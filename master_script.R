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

aws.signature::use_credentials(profile = 'joestradamus')





##########################
## CONNECT TO DATABASE

# load credentials
credentials = fromJSON('db_credentials.json')$db

# creates a connection to the postgres database
con <- dbConnect(drv = dbDriver('PostgreSQL'),
                 host = credentials$PGHOST,
                 dbname = credentials$PGDATABASE,
                 user = credentials$PGUSER,
                 password = credentials$PGPASSWORD,
                 port = credentials$PGPORT)

# remove credentials
rm (credentials) 



##########################
## LOAD FUNCTIONS

source('etl/prep_data.R')
source('modeling/modeling.R')



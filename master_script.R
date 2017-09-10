setwd('/Users/joewalsh/git-projects/traffic_safety/')

require('checkpoint')
checkpoint('2017-08-01')

require('mlr')
require('RPostgreSQL')

source('prep_data.R')
#source('modeling.R')

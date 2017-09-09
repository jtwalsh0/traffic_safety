# 1. Prep data
# 2. Create design matrices
# 3. Create label matrices

# download raw data from s3
aws.signature::use_credentials(profile = 'joestradamus')
aws.s3::save_object("CareExport1.csv", 
                    file="data/CareExport1.csv", 
                    bucket="transportation-safety-data")


##########################
## FEATURES GENERATION

# function:
#   input:
#     features_start_date
#     features_end_date
#     geographic_id
#     add columns of random data, parameter z
#   output:
#     store as csv




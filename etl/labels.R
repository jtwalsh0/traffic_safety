# 1. Prep data
# 2. Create design matrices
# 3. Create label matrices

# download raw data from s3
aws.signature::use_credentials(profile = 'joestradamus')
aws.s3::save_object("CareExport1.csv", 
                    file="data/CareExport1.csv", 
                    bucket="transportation-safety-data")



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


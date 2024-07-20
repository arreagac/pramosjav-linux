 #!/bin/bash

# Declare an array of the dates you want to process
declare -a dates=("20230717" "20230718" "20230719" "20230720" "20230721" "20230722" "20230723" "20230724" "20230725" "20230726" "20230727" "20230728" "20230729" "20230730" "20230731")

# Loop through each date and run the AWS S3 copy command
for date in "${dates[@]}"
do
  aws s3 cp s3://sharethis-in/cookie-sdf/dt=${date}/ s3://customer-interphase-use1/global_cookie_historical/dt=${date}/ --storage-class STANDARD --recursive --force-glacier-transfer
done

 #!/bin/bash

# Declare an array of the dates you want to process
declare -a dates=("20230816" "20230817" "20230818" "20230819" "20230820" "20230821" "20230822" "20230823" "20230824" "20230825" "20230826" "20230827" "20230828" "20230829" "20230830" "20230831")

# Loop through each date and run the AWS S3 copy command
for date in "${dates[@]}"
do
  aws s3 cp s3://sharethis-in/cookie-sdf/dt=${date}/ s3://customer-interphase-use1/global_cookie_historical/dt=${date}/ --storage-class STANDARD --recursive --force-glacier-transfer
done


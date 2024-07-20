 #!/bin/bash

# Declare an array of the dates you want to process
declare -a dates=("20240211" "20240212" "20240213" "20240214" "20240215" "20240216" "20240217" "20240218" "20240219" "20240220" "20240221" "20240222" "20240223" "20240224" "20240225" "20240226" "20240227" "20240228" "20240229")

# Loop through each date and run the AWS S3 copy command
for date in "${dates[@]}"
do
  aws s3 cp s3://sharethis-in/cookie-sdf/dt=${date}/ s3://customer-interphase-use1/global_cookie_historical/dt=${date}/ --storage-class STANDARD --recursive --force-glacier-transfer
done


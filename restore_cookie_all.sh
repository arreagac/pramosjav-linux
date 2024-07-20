 #!/bin/bash

# Declare an array of the dates you want to process
declare -a dates=("20240303" "20240304" "20240305" "20240306" "20240307" "20240308" "20240309" "20240310" "20240311" "20240312" "20240313" "20240314" "20240315" "20240316" "20240317" "20240318" "20240319" "20240320" "20240321" "20240322" "20240323" "20240324" "20240325" "20240326" "20240327" "20240328" "20240329" "20240330" "20240331" "20240201" "20240202" "20240203" "20240204" "20240205" "20240206" "20240207" "20240208" "20240209" "20240210" "20240211" "20240212" "20240213" "20240214" "20240215" "20240216" "20240217" "20240218" "20240219" "20240220" "20240221" "20240222" "20240223" "20240224" "20240225" "20240226" "20240227" "20240228" "20240229" "20230701" "20230702" "20230703" "20230704" "20230705" "20230706" "20230707" "20230708" "20230709" "20230710" "20230711" "20230712" "20230713" "20230714" "20230715" "20230716" "20230717" "20230718" "20230719" "20230720" "20230721" "20230722" "20230723" "20230724" "20230725" "20230726" "20230727" "20230728" "20230729" "20230730" "20230731" "20240801" "20240802" "20240803" "20240804" "20240805" "20240806" "20240807" "20240808" "20240809" "20240810" "20240811" "20240812" "20240813" "20240814" "20240815" "20240816" "20240817" "20240818" "20240819" "20240820" "20240821" "20240822" "20240823" "20240824" "20240825" "20240826" "20240827" "20240828" "20240829" "20240830" "20240831")

# Loop through each date and run the AWS S3 copy command
for date in "${dates[@]}"
do
  aws s3 cp s3://sharethis-in/cookie-sdf/dt=${date}/ s3://customer-interphase-use1/global_cookie_historical/dt=${date}/ --storage-class STANDARD --recursive --force-glacier-transfer
done

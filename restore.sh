 #!/bin/bash

BUCKET="sharethis-in"
PREFIX="cookie-sdf/dt=20240301"
DAYS=10 # Number of days for which the restored object will be available

# List all objects in the specified directory (prefix)
aws s3api list-objects-v2 --bucket $BUCKET --prefix $PREFIX --query 'Contents[].{Key: Key}' --output text |
while read KEY; do
    echo "Restoring $KEY"
    aws s3api restore-object --bucket $BUCKET --key "$KEY" --restore-request Days=$DAYS,GlacierJobParameters={Tier="Bulk"}
done

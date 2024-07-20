 #!/bin/bash

BUCKET="sharethis-in"
DAYS=10 # Number of days for which the restored object will be available
TIER="Bulk" # Retrieval tier (can be "Bulk", "Standard", or "Expedited")

# List of directory prefixes to restore
PREFIXES=(
    "cookie-sdf/dt=20230801"
    "cookie-sdf/dt=20230802"
    "cookie-sdf/dt=20230803"
    "cookie-sdf/dt=20230804"
    "cookie-sdf/dt=20230805"
    "cookie-sdf/dt=20230806"
    "cookie-sdf/dt=20230807"
    "cookie-sdf/dt=20230808"
    "cookie-sdf/dt=20230809"
    "cookie-sdf/dt=20230810"
    "cookie-sdf/dt=20230811"
    "cookie-sdf/dt=20230812"
    "cookie-sdf/dt=20230813"
    "cookie-sdf/dt=20230814"
    "cookie-sdf/dt=20230815"
    "cookie-sdf/dt=20230816"
    "cookie-sdf/dt=20230817"
    "cookie-sdf/dt=20230818"
    "cookie-sdf/dt=20230819"
    "cookie-sdf/dt=20230820"
    "cookie-sdf/dt=20230821"
    "cookie-sdf/dt=20230822"
    "cookie-sdf/dt=20230823"
    "cookie-sdf/dt=20230824"
    "cookie-sdf/dt=20230825"
    "cookie-sdf/dt=20230826"
    "cookie-sdf/dt=20230827"
    "cookie-sdf/dt=20230828"
    "cookie-sdf/dt=20230829"
    "cookie-sdf/dt=20230830"
    "cookie-sdf/dt=20230831"
    # Add more prefixes as needed
)

for PREFIX in "${PREFIXES[@]}"; do
    echo "Processing directory: $PREFIX"
    # List all objects in the specified directory (prefix)
    aws s3api list-objects-v2 --bucket $BUCKET --prefix $PREFIX --query 'Contents[].{Key: Key}' --output text |
    while read -r KEY; do
        echo "Restoring $KEY"
        aws s3api restore-object --bucket $BUCKET --key "$KEY" --restore-request Days=$DAYS,GlacierJobParameters={Tier=$TIER}
    done
done



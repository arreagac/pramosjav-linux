 #!/bin/bash

BUCKET="sharethis-in"
DAYS=10 # Number of days for which the restored object will be available
TIER="Bulk" # Retrieval tier (can be "Bulk", "Standard", or "Expedited")

# List of directory prefixes to restore
PREFIXES=(
    "cookie-sdf/dt=20240301"
    # Add more prefixes as needed
)


# Step 2: Check the restore status periodically
echo "Checking restore status..."
for PREFIX in "${PREFIXES[@]}"; do
    aws s3api list-objects-v2 --bucket $BUCKET --prefix $PREFIX --query 'Contents[].{Key: Key}' --output text |
    while read -r KEY; do
        STATUS=$(aws s3api head-object --bucket $BUCKET --key "$KEY" --query 'Restore' --output text)
        if [[ $STATUS == "None" ]]; then
            echo "$KEY: No restore request found"
        elif [[ $STATUS == "true" ]]; then
            echo "$KEY: Restore completed"
        else
            echo "$KEY: $STATUS"
        fi
    done
done

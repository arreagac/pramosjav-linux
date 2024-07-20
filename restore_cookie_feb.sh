 #!/bin/bash

BUCKET="sharethis-in"
DAYS=10 # Number of days for which the restored object will be available
TIER="Bulk" # Retrieval tier (can be "Bulk", "Standard", or "Expedited")

# List of directory prefixes to restore
PREFIXES=(
    "cookie-sdf/dt=20240201"
    "cookie-sdf/dt=20240202"
    "cookie-sdf/dt=20240203"
    "cookie-sdf/dt=20240204"
    "cookie-sdf/dt=20240205"
    "cookie-sdf/dt=20240206"
    "cookie-sdf/dt=20240207"
    "cookie-sdf/dt=20240208"
    "cookie-sdf/dt=20240209"
    "cookie-sdf/dt=20240210"
    "cookie-sdf/dt=20240211"
    "cookie-sdf/dt=20240212"
    "cookie-sdf/dt=20240213"
    "cookie-sdf/dt=20240214"
    "cookie-sdf/dt=20240215"
    "cookie-sdf/dt=20240216"
    "cookie-sdf/dt=20240217"
    "cookie-sdf/dt=20240218"
    "cookie-sdf/dt=20240219"
    "cookie-sdf/dt=20240220"
    "cookie-sdf/dt=20240221"
    "cookie-sdf/dt=20240222"
    "cookie-sdf/dt=20240223"
    "cookie-sdf/dt=20240224"
    "cookie-sdf/dt=20240225"
    "cookie-sdf/dt=20240226"
    "cookie-sdf/dt=20240227"
    "cookie-sdf/dt=20240228"
    "cookie-sdf/dt=20240229"
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

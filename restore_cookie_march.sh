 #!/bin/bash

BUCKET="sharethis-in"
DAYS=10 # Number of days for which the restored object will be available
TIER="Bulk" # Retrieval tier (can be "Bulk", "Standard", or "Expedited")

# List of directory prefixes to restore
PREFIXES=(
    "cookie-sdf/dt=20240302"
    "cookie-sdf/dt=20240303"
    "cookie-sdf/dt=20240304"
    "cookie-sdf/dt=20240305"
    "cookie-sdf/dt=20240306"
    "cookie-sdf/dt=20240307"
    "cookie-sdf/dt=20240308"
    "cookie-sdf/dt=20240309"
    "cookie-sdf/dt=20240310"
    "cookie-sdf/dt=20240311"
    "cookie-sdf/dt=20240312"
    "cookie-sdf/dt=20240313"
    "cookie-sdf/dt=20240314"
    "cookie-sdf/dt=20240315"
    "cookie-sdf/dt=20240316"
    "cookie-sdf/dt=20240317"
    "cookie-sdf/dt=20240318"
    "cookie-sdf/dt=20240319"
    "cookie-sdf/dt=20240320"
    "cookie-sdf/dt=20240321"
    "cookie-sdf/dt=20240322"
    "cookie-sdf/dt=20240323"
    "cookie-sdf/dt=20240324"
    "cookie-sdf/dt=20240325"
    "cookie-sdf/dt=20240326"
    "cookie-sdf/dt=20240327"
    "cookie-sdf/dt=20240328"
    "cookie-sdf/dt=20240329"
    "cookie-sdf/dt=20240330"
    "cookie-sdf/dt=20240331"
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

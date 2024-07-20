 #!/bin/bash

BUCKET="sharethis-in"
DAYS=10 # Number of days for which the restored object will be available
TIER="Bulk" # Retrieval tier (can be "Bulk", "Standard", or "Expedited")

# List of directory prefixes to restore
PREFIXES=(
    "cookie-sdf/dt=20230701"
    "cookie-sdf/dt=20230702"
    "cookie-sdf/dt=20230703"
    "cookie-sdf/dt=20230704"
    "cookie-sdf/dt=20230705"
    "cookie-sdf/dt=20230706"
    "cookie-sdf/dt=20230707"
    "cookie-sdf/dt=20230708"
    "cookie-sdf/dt=20230709"
    "cookie-sdf/dt=20230710"
    "cookie-sdf/dt=20230711"
    "cookie-sdf/dt=20230712"
    "cookie-sdf/dt=20230713"
    "cookie-sdf/dt=20230714"
    "cookie-sdf/dt=20230715"
    "cookie-sdf/dt=20230716"
    "cookie-sdf/dt=20230717"
    "cookie-sdf/dt=20230718"
    "cookie-sdf/dt=20230719"
    "cookie-sdf/dt=20230720"
    "cookie-sdf/dt=20230721"
    "cookie-sdf/dt=20230722"
    "cookie-sdf/dt=20230723"
    "cookie-sdf/dt=20230724"
    "cookie-sdf/dt=20230725"
    "cookie-sdf/dt=20230726"
    "cookie-sdf/dt=20230727"
    "cookie-sdf/dt=20230728"
    "cookie-sdf/dt=20230729"
    "cookie-sdf/dt=20230730"
    "cookie-sdf/dt=20230731"
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


#!/bin/bash

# Initialize Firebase Hosting
# This script will set up Firebase Hosting for the project

set -e

PROJECT_ID="azamposweb"
SITE_ID="azamposweb"

echo "🔧 Initializing Firebase Hosting..."
echo "Project: $PROJECT_ID"
echo "Site ID: $SITE_ID"
echo ""

# Set the project
firebase use $PROJECT_ID

# Initialize hosting with automatic responses
echo "Initializing Firebase Hosting..."
echo "This will create a new hosting site if needed."
echo ""

# Try to create the site first
if firebase hosting:sites:create $SITE_ID 2>/dev/null; then
    echo "✅ Site created: $SITE_ID"
else
    echo "ℹ️  Site might already exist or will be created during init"
fi

# Now initialize hosting
cat <<EOF | firebase init hosting --project $PROJECT_ID
build/web
y
$SITE_ID
n
EOF

echo ""
echo "✅ Firebase Hosting initialized!"
echo ""
echo "You can now deploy with:"
echo "  ./deploy-firebase.sh"
echo "  or"
echo "  firebase deploy --only hosting"

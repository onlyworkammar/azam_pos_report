#!/bin/bash

# Deploy Flutter Web App to Cloud Storage (Static Hosting)
# This is simpler and cheaper than Cloud Run for static files

set -e

PROJECT_ID="azamposweb"
BUCKET_NAME="azam-pos-report-web"
REGION="us-central1"

echo "🚀 Starting deployment to Cloud Storage..."
echo "Project ID: $PROJECT_ID"
echo "Bucket Name: $BUCKET_NAME"
echo "Region: $REGION"

# Check if gcloud is installed
if ! command -v gcloud &> /dev/null; then
    echo "❌ Error: gcloud CLI is not installed. Please install it first."
    exit 1
fi

# Check if Flutter is installed
if ! command -v flutter &> /dev/null; then
    echo "❌ Error: Flutter is not installed. Please install it first."
    exit 1
fi

# Set the project
echo "📋 Setting GCP project..."
gcloud config set project $PROJECT_ID

# Enable required APIs
echo "🔧 Enabling required GCP APIs..."
gcloud services enable storage-component.googleapis.com

# Create bucket if it doesn't exist
echo "🪣 Checking/Creating Cloud Storage bucket..."
if ! gsutil ls -b gs://$BUCKET_NAME &> /dev/null; then
    echo "Creating bucket: $BUCKET_NAME"
    gsutil mb -p $PROJECT_ID -c STANDARD -l $REGION gs://$BUCKET_NAME
    echo "✅ Bucket created"
else
    echo "✅ Bucket already exists"
fi

# Build Flutter web app
echo "🏗️  Building Flutter web app..."
flutter clean
flutter pub get
flutter build web --release --base-href="/"

# Upload to Cloud Storage
echo "📤 Uploading files to Cloud Storage..."
gsutil -m rsync -r -d build/web gs://$BUCKET_NAME

# Set bucket to serve static website
echo "🌐 Configuring bucket for static website hosting..."
gsutil web set -m index.html -e index.html gs://$BUCKET_NAME

# Make bucket publicly readable
echo "🔓 Making bucket publicly readable..."
gsutil iam ch allUsers:objectViewer gs://$BUCKET_NAME

# Get the public URL
BUCKET_URL="https://storage.googleapis.com/$BUCKET_NAME/index.html"
echo ""
echo "✅ Deployment completed successfully!"
echo ""
echo "🌐 Your app is available at:"
echo "   $BUCKET_URL"
echo ""
echo "📝 Note: You can also access it via:"
echo "   https://$BUCKET_NAME.storage.googleapis.com"
echo ""
echo "💡 To set up a custom domain, use Cloud CDN or Cloud Load Balancer"

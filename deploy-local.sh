#!/bin/bash

# Local build and deploy to GCP Cloud Run
# This script builds locally and pushes to Cloud Run

set -e

PROJECT_ID="azamposweb"
SERVICE_NAME="azam-pos-report"
REGION="us-central1"
IMAGE_NAME="gcr.io/$PROJECT_ID/$SERVICE_NAME"

echo "🚀 Building Docker image locally..."
docker build -t $IMAGE_NAME:latest .

echo "📤 Pushing image to GCP Container Registry..."
gcloud auth configure-docker
docker push $IMAGE_NAME:latest

echo "🚀 Deploying to Cloud Run..."
gcloud run deploy $SERVICE_NAME \
  --image $IMAGE_NAME:latest \
  --platform managed \
  --region $REGION \
  --allow-unauthenticated \
  --port 80 \
  --memory 512Mi \
  --cpu 1 \
  --min-instances 0 \
  --max-instances 10

echo "✅ Deployment completed!"
echo ""
echo "🌐 Your app is available at:"
gcloud run services describe $SERVICE_NAME --region=$REGION --format='value(status.url)'

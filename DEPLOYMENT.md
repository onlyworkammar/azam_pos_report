# GCP Deployment Guide for AZAM POS Report

This guide explains how to deploy the Flutter web app to Google Cloud Platform (GCP).

## Prerequisites

1. **Google Cloud Account** with billing enabled
2. **gcloud CLI** installed and configured
3. **Docker** installed (for local deployment option)
4. **Project ID**: `azamposweb`

## Initial Setup

### 1. Install gcloud CLI

```bash
# macOS
brew install google-cloud-sdk

# Or download from: https://cloud.google.com/sdk/docs/install
```

### 2. Authenticate and Set Project

```bash
# Login to GCP
gcloud auth login

# Set the project
gcloud config set project azamposweb

# Verify project
gcloud config get-value project
```

### 3. Enable Required APIs

```bash
gcloud services enable cloudbuild.googleapis.com
gcloud services enable run.googleapis.com
gcloud services enable containerregistry.googleapis.com
```

## Deployment Options

### Option 1: Cloud Build (Recommended - Automated)

This uses GCP Cloud Build to build and deploy automatically.

```bash
# Make script executable
chmod +x deploy.sh

# Run deployment
./deploy.sh
```

This will:
1. Build the Flutter web app
2. Create a Docker image
3. Push to Container Registry
4. Deploy to Cloud Run

### Option 2: Local Build and Deploy

Build locally and push to Cloud Run.

```bash
# Make script executable
chmod +x deploy-local.sh

# Run deployment
./deploy-local.sh
```

### Option 3: Manual Deployment

#### Step 1: Build Flutter Web App

```bash
flutter pub get
flutter build web --release --web-renderer canvaskit
```

#### Step 2: Build Docker Image

```bash
docker build -t gcr.io/azamposweb/azam-pos-report:latest .
```

#### Step 3: Push to Container Registry

```bash
gcloud auth configure-docker
docker push gcr.io/azamposweb/azam-pos-report:latest
```

#### Step 4: Deploy to Cloud Run

```bash
gcloud run deploy azam-pos-report \
  --image gcr.io/azamposweb/azam-pos-report:latest \
  --platform managed \
  --region us-central1 \
  --allow-unauthenticated \
  --port 80 \
  --memory 512Mi \
  --cpu 1
```

## Configuration

### Update Backend API URL

Before deploying, make sure to update the API base URL in your code if your backend is hosted elsewhere:

**File**: `lib/services/api_service.dart`

```dart
static const String baseUrl = 'https://your-backend-api.com/api/v1';
```

Or use environment variables (requires additional setup).

### Custom Domain (Optional)

To use a custom domain:

```bash
gcloud run domain-mappings create \
  --service azam-pos-report \
  --domain yourdomain.com \
  --region us-central1
```

## Monitoring

### View Logs

```bash
gcloud run services logs read azam-pos-report --region us-central1
```

### View Service Details

```bash
gcloud run services describe azam-pos-report --region us-central1
```

### Get Service URL

```bash
gcloud run services describe azam-pos-report \
  --region us-central1 \
  --format='value(status.url)'
```

## Updating the Deployment

To update the app after making changes:

```bash
# Simply run the deployment script again
./deploy.sh
```

Or if using local build:

```bash
./deploy-local.sh
```

## Cost Optimization

The current configuration uses:
- **Memory**: 512Mi (minimum for nginx)
- **CPU**: 1 vCPU
- **Min instances**: 0 (scales to zero when not in use)
- **Max instances**: 10

This setup should be within the free tier for low traffic. Adjust based on your needs.

## Troubleshooting

### Build Fails

- Check that all dependencies are in `pubspec.yaml`
- Verify Flutter SDK version compatibility
- Check Cloud Build logs: `gcloud builds list`

### Deployment Fails

- Ensure APIs are enabled
- Check IAM permissions
- Verify project ID is correct

### App Not Loading

- Check Cloud Run logs
- Verify the service is deployed: `gcloud run services list`
- Check the service URL is correct

## Security Notes

- The app is deployed with `--allow-unauthenticated` for public access
- For production, consider adding authentication
- Ensure your backend API has proper CORS configuration
- Use HTTPS (automatically provided by Cloud Run)

## Support

For issues or questions:
1. Check Cloud Run logs
2. Review Cloud Build logs
3. Verify service configuration

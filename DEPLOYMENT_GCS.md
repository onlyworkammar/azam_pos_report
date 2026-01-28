# Cloud Storage Deployment Guide

This guide explains how to deploy the Flutter web app to Google Cloud Storage for static hosting.

## Why Cloud Storage?

- ✅ **Much cheaper** than Cloud Run (pay only for storage and bandwidth)
- ✅ **Simpler** - no containers, just static files
- ✅ **Fast** - served directly from Google's CDN
- ✅ **Perfect for static web apps** like Flutter web

## Prerequisites

1. **Google Cloud Account** with billing enabled
2. **gcloud CLI** installed and configured
3. **Flutter SDK** installed locally
4. **Project ID**: `azamposweb`

## Quick Deployment

```bash
# Make script executable
chmod +x deploy-gcs.sh

# Run deployment
./deploy-gcs.sh
```

That's it! Your app will be deployed to Cloud Storage.

## Manual Steps

### 1. Build Flutter Web App

```bash
flutter clean
flutter pub get
flutter build web --release
```

### 2. Create Cloud Storage Bucket

```bash
gsutil mb -p azamposweb -c STANDARD -l us-central1 gs://azam-pos-report-web
```

### 3. Upload Files

```bash
gsutil -m rsync -r -d build/web gs://azam-pos-report-web
```

### 4. Enable Static Website Hosting

```bash
gsutil web set -m index.html -e index.html gs://azam-pos-report-web
```

### 5. Make Public

```bash
gsutil iam ch allUsers:objectViewer gs://azam-pos-report-web
```

## Access Your App

After deployment, your app will be available at:

```
https://storage.googleapis.com/azam-pos-report-web/index.html
```

Or:

```
https://azam-pos-report-web.storage.googleapis.com
```

## Custom Domain (Optional)

### Option 1: Cloud CDN + Load Balancer

1. Create a Cloud Storage backend bucket
2. Set up Cloud CDN
3. Configure Load Balancer
4. Point your domain to the Load Balancer IP

### Option 2: Firebase Hosting (Recommended for Custom Domain)

Firebase Hosting is built on top of Cloud Storage and makes custom domains easier:

```bash
# Install Firebase CLI
npm install -g firebase-tools

# Login
firebase login

# Initialize (select Hosting)
firebase init hosting

# Deploy
firebase deploy --only hosting
```

## Updating the App

To update after making changes:

```bash
./deploy-gcs.sh
```

Or manually:

```bash
flutter build web --release
gsutil -m rsync -r -d build/web gs://azam-pos-report-web
```

## Cost Comparison

### Cloud Storage Static Hosting:
- Storage: ~$0.020 per GB/month
- Bandwidth: ~$0.12 per GB
- **Estimated cost for low traffic: < $1/month**

### Cloud Run (previous approach):
- CPU/Memory: ~$0.00002400 per vCPU-second
- Requests: First 2 million free
- **Estimated cost: $5-20/month minimum**

## CORS Configuration

If you need to configure CORS for your FastAPI backend, you can create a CORS config file:

**cors.json:**
```json
[
  {
    "origin": ["*"],
    "method": ["GET", "POST", "PUT", "DELETE", "OPTIONS"],
    "responseHeader": ["Content-Type", "Authorization"],
    "maxAgeSeconds": 3600
  }
]
```

Then apply it:

```bash
gsutil cors set cors.json gs://azam-pos-report-web
```

## Security

The bucket is set to be publicly readable for static hosting. If you need authentication:

1. Use Cloud CDN with signed URLs
2. Use Cloud IAM to restrict access
3. Use Firebase Hosting with authentication

## Troubleshooting

### Error: Bucket already exists
- The bucket name might be taken globally (must be unique)
- Try a different bucket name in `deploy-gcs.sh`

### Error: Permission denied
- Make sure you have Storage Admin role
- Run: `gcloud projects add-iam-policy-binding azamposweb --member="user:YOUR_EMAIL" --role="roles/storage.admin"`

### App not loading
- Check bucket permissions: `gsutil iam get gs://azam-pos-report-web`
- Verify files uploaded: `gsutil ls -r gs://azam-pos-report-web`
- Check website configuration: `gsutil web get gs://azam-pos-report-web`

## API Configuration

Your Flutter app is already configured to call your FastAPI backend at:
```
https://fastapi-app-340110482520.us-central1.run.app/api/v1
```

This is set in `lib/services/api_service.dart` and will work from the Cloud Storage hosted app.

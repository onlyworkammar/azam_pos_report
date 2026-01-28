# Quick Start - Deploy to GCP

## Prerequisites Check

```bash
# Check if gcloud is installed
gcloud --version

# Check if you're logged in
gcloud auth list

# Check current project
gcloud config get-value project
```

## One-Command Deployment

```bash
# Make sure you're in the project directory
cd /Users/adexsoft/Documents/GitHub/azam_pos_report

# Run the deployment script
./deploy.sh
```

That's it! The script will:
1. ✅ Set project to `azamposweb`
2. ✅ Enable required APIs
3. ✅ Build Flutter web app
4. ✅ Create Docker image
5. ✅ Deploy to Cloud Run
6. ✅ Show you the URL

## First Time Setup

If this is your first time deploying:

```bash
# 1. Login to GCP
gcloud auth login

# 2. Set the project
gcloud config set project azamposweb

# 3. Enable billing (if not already enabled)
# Visit: https://console.cloud.google.com/billing

# 4. Run deployment
./deploy.sh
```

## After Deployment

Your app will be available at a URL like:
```
https://azam-pos-report-xxxxx-uc.a.run.app
```

The script will display the exact URL at the end.

## Update Deployment

To update after making code changes:

```bash
./deploy.sh
```

## Troubleshooting

**Error: Project not found**
```bash
gcloud projects list
gcloud config set project azamposweb
```

**Error: Billing not enabled**
- Visit GCP Console and enable billing for the project

**Error: APIs not enabled**
```bash
gcloud services enable cloudbuild.googleapis.com
gcloud services enable run.googleapis.com
gcloud services enable containerregistry.googleapis.com
```

**View logs**
```bash
gcloud run services logs read azam-pos-report --region us-central1 --limit 50
```

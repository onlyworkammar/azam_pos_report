# Firebase Hosting Quick Setup

Your Flutter app is built and ready! You just need to create the hosting site.

## Step 1: Create Hosting Site (Required)

**Option A: Via Firebase Console (Easiest - Recommended)**

1. Go to: https://console.firebase.google.com/project/azamposweb/hosting
2. Click **"Get Started"** or **"Add another site"**
3. Enter site ID: `azamposweb` (or any unique name)
4. Click **"Continue"**

**Option B: Via CLI**

If the API is enabled, you can try:
```bash
firebase hosting:sites:create azamposweb
```

## Step 2: Deploy

Once the site is created, run:

```bash
firebase deploy --only hosting
```

That's it! Your app will be live at:
- `https://azamposweb.web.app`
- `https://azamposweb.firebaseapp.com`

## What's Already Done ✅

- ✅ Flutter web app built (`build/web`)
- ✅ Firebase CLI installed and logged in
- ✅ Project set to `azamposweb`
- ✅ `firebase.json` configured
- ✅ `.firebaserc` configured

## After Deployment

Your Flutter frontend will automatically connect to your FastAPI backend at:
`https://fastapi-app-340110482520.us-central1.run.app/api/v1`

## Update After Changes

```bash
flutter build web --release
firebase deploy --only hosting
```

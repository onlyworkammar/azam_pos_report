# Firebase Hosting Setup - Manual Steps

The error you're seeing means Firebase Hosting needs to be initialized. Here's how to fix it:

## Option 1: Initialize via Firebase Console (Recommended)

1. Go to [Firebase Console](https://console.firebase.google.com)
2. Select project: **azamposweb**
3. Click on **Hosting** in the left menu
4. Click **Get Started** or **Add another site**
5. Enter site ID: `azamposweb` (or any unique name)
6. Click **Continue**

This will automatically create the hosting site.

## Option 2: Initialize via CLI (Interactive)

Run this command and follow the prompts:

```bash
firebase init hosting
```

When prompted:
- **What do you want to use as your public directory?** → `build/web`
- **Configure as a single-page app?** → `Yes`
- **Set up automatic builds and deploys with GitHub?** → `No`
- **Site ID** → `azamposweb` (or accept default)

## Option 3: Quick Fix Script

After the site is created (via Console or CLI), you can deploy:

```bash
# Build the app
flutter build web --release

# Deploy
firebase deploy --only hosting
```

## Verify Setup

Check if hosting is set up:

```bash
firebase hosting:sites:list
```

You should see your site listed.

## After Setup

Once hosting is initialized, you can use:

```bash
./deploy-firebase.sh
```

This will build and deploy automatically.

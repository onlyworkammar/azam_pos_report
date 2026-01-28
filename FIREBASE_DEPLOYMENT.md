# Firebase Hosting Deployment Guide

This guide explains how to deploy the Flutter web app to Firebase Hosting.

## Why Firebase Hosting?

- ✅ **Free tier** - Generous free tier for small projects
- ✅ **Auto HTTPS** - SSL certificates automatically configured
- ✅ **Global CDN** - Fast content delivery worldwide
- ✅ **Easy CLI** - Simple deployment process
- ✅ **Custom domains** - Easy to add custom domains
- ✅ **Great for Flutter** - Optimized for single-page applications

## Prerequisites

1. **Firebase CLI** installed:
   ```bash
   npm install -g firebase-tools
   ```

2. **Flutter SDK** installed

3. **Firebase project** created (or use existing: `azamposweb`)

## Quick Deployment

### Step 1: Login to Firebase

```bash
firebase login
```

This will open a browser window for authentication.

### Step 2: Run Deployment Script

```bash
./deploy-firebase.sh
```

That's it! The script will:
1. ✅ Login to Firebase (if needed)
2. ✅ Set project to `azamposweb`
3. ✅ Initialize Firebase Hosting (if needed)
4. ✅ Build Flutter web app
5. ✅ Deploy to Firebase Hosting

## Manual Deployment

If you prefer to do it manually:

### 1. Login to Firebase

```bash
firebase login
```

### 2. Initialize Firebase Hosting

```bash
firebase init hosting
```

When prompted:
- **What do you want to use as your public directory?** → `build/web`
- **Configure as a single-page app?** → `Yes`
- **Set up automatic builds and deploys with GitHub?** → `No` (or Yes if you want)

### 3. Build Flutter Web App

```bash
flutter clean
flutter pub get
flutter build web --release
```

### 4. Deploy

```bash
firebase deploy --only hosting
```

## Access Your App

After deployment, your app will be available at:

- **Primary URL**: `https://azamposweb.web.app`
- **Alternative URL**: `https://azamposweb.firebaseapp.com`

## Updating the App

To update after making changes:

```bash
./deploy-firebase.sh
```

Or manually:

```bash
flutter build web --release
firebase deploy --only hosting
```

## Custom Domain

To add a custom domain:

1. Go to [Firebase Console](https://console.firebase.google.com)
2. Select your project
3. Go to Hosting → Add custom domain
4. Follow the instructions to verify domain ownership
5. Firebase will automatically configure SSL

## Configuration Files

- **firebase.json** - Firebase Hosting configuration
- **.firebaserc** - Firebase project configuration

These files are already created and configured for you.

## Features

### Automatic Routing
The configuration includes a rewrite rule to handle Flutter's client-side routing:
```json
{
  "source": "**",
  "destination": "/index.html"
}
```

### Caching
Optimized caching headers for:
- JavaScript files (1 year cache)
- Images (1 year cache)
- Fonts (1 year cache)

### Build Output
The app is built to `build/web` and deployed from there.

## Cost

Firebase Hosting free tier includes:
- **10 GB storage**
- **360 MB/day bandwidth**
- **Unlimited sites**

For most small to medium projects, this is completely free!

## Troubleshooting

### Error: Not logged in
```bash
firebase login
```

### Error: Project not found
```bash
firebase use azamposweb
```

Or create a new project:
```bash
firebase projects:create azamposweb
```

### Error: Build fails
Make sure Flutter is properly installed:
```bash
flutter doctor
```

### View deployment history
```bash
firebase hosting:channel:list
```

### Rollback to previous version
```bash
firebase hosting:clone SOURCE_SITE_ID:SOURCE_CHANNEL_ID TARGET_SITE_ID:live
```

## Support

For issues or questions:
1. Check Firebase Console: https://console.firebase.google.com
2. View deployment logs: `firebase hosting:channel:list`
3. Firebase Documentation: https://firebase.google.com/docs/hosting

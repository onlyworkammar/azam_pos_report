# Quick Start - Firebase Hosting

## Step 1: Login to Firebase

```bash
firebase login
```

This will open a browser window. Complete the authentication.

## Step 2: Deploy

```bash
./deploy-firebase.sh
```

That's it! Your app will be live at:
- `https://azamposweb.web.app`
- `https://azamposweb.firebaseapp.com`

## What the script does:

1. ✅ Checks Firebase login
2. ✅ Sets project to `azamposweb`
3. ✅ Builds Flutter web app
4. ✅ Deploys to Firebase Hosting

## Update after changes:

Just run the script again:
```bash
./deploy-firebase.sh
```

#!/bin/bash

# Deploy Flutter Web App to Firebase Hosting
# Project ID: azamposweb

set -e

PROJECT_ID="azamposweb-a9023"

echo "🚀 Deploying Flutter web app to Firebase Hosting..."
echo "Project ID: $PROJECT_ID"
echo ""

# Check if Firebase CLI is installed
if ! command -v firebase &> /dev/null; then
    echo "❌ Error: Firebase CLI is not installed."
    echo "   Install it with: npm install -g firebase-tools"
    exit 1
fi

# Check if Flutter is installed
if ! command -v flutter &> /dev/null; then
    echo "❌ Error: Flutter is not installed."
    exit 1
fi

# Check if logged in to Firebase
if ! firebase login:list 2>/dev/null | grep -q "@"; then
    echo "❌ Error: Not logged in to Firebase."
    echo ""
    echo "Please run this command first:"
    echo "   firebase login"
    echo ""
    echo "This will open a browser window for authentication."
    exit 1
fi

# Set the project
echo "📋 Setting Firebase project to $PROJECT_ID..."
firebase use $PROJECT_ID

# Check if hosting is initialized
if ! firebase hosting:sites:list 2>/dev/null | grep -q "."; then
    echo "❌ Error: Firebase Hosting is not initialized."
    echo ""
    echo "Please initialize it first:"
    echo "  1. Go to https://console.firebase.google.com"
    echo "  2. Select project: azamposweb"
    echo "  3. Click 'Hosting' → 'Get Started'"
    echo "  4. Create a site (e.g., 'azamposweb')"
    echo ""
    echo "Or run: firebase init hosting"
    exit 1
fi

# Build Flutter web app
echo "🏗️  Building Flutter web app..."
flutter clean
flutter pub get
flutter build web --release

# Deploy to Firebase Hosting
echo "📤 Deploying to Firebase Hosting..."
firebase deploy --only hosting

echo ""
echo "✅ Deployment completed successfully!"
echo ""
echo "🌐 Your app should be available at:"
firebase hosting:sites:list 2>/dev/null | grep "$PROJECT_ID" || echo "   https://$PROJECT_ID.web.app"
echo "   https://$PROJECT_ID.firebaseapp.com"

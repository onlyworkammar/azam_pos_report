#!/bin/bash

# Fix content types for Flutter web app on Cloud Storage
# This ensures JavaScript and other files are served with correct MIME types

BUCKET_NAME="azam-pos-report-web"

echo "🔧 Setting correct content types for files..."

# Set content types for JavaScript files
gsutil -m setmeta -h "Content-Type:text/javascript" \
  gs://$BUCKET_NAME/*.js \
  gs://$BUCKET_NAME/**/*.js

# Set content type for HTML
gsutil setmeta -h "Content-Type:text/html" \
  gs://$BUCKET_NAME/index.html

# Set content type for JSON files
gsutil -m setmeta -h "Content-Type:application/json" \
  gs://$BUCKET_NAME/*.json \
  gs://$BUCKET_NAME/**/*.json

# Set content type for WASM files
gsutil -m setmeta -h "Content-Type:application/wasm" \
  gs://$BUCKET_NAME/**/*.wasm

# Set content type for CSS (if any)
gsutil -m setmeta -h "Content-Type:text/css" \
  gs://$BUCKET_NAME/**/*.css

# Set content type for fonts
gsutil -m setmeta -h "Content-Type:font/otf" \
  gs://$BUCKET_NAME/**/*.otf

gsutil -m setmeta -h "Content-Type:font/ttf" \
  gs://$BUCKET_NAME/**/*.ttf

# Set content type for images
gsutil -m setmeta -h "Content-Type:image/png" \
  gs://$BUCKET_NAME/**/*.png

echo "✅ Content types updated!"

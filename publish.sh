#!/bin/bash

set -e # Stop if fail

echo "=== Quartz Automation Deployment Script ==="

# 1. DEFINE PATHS
# Adjust these based on your actual folder structure
NOTES_SOURCE_DIR="../_published"
CONTENT_DIR="content" 
OUTPUT_DIR="_site" # Default Quartz output folder (check quartz.config.ts for 'public' setting)

# Ensure directories exist
mkdir -p "$CONTENT_DIR"

echo "[1/2] Synchronizing latest markdown files..."
# Copy/Pull all new files from notes/_published to content/content
# We use cp to keep the file structure. 
# If you want to filter by date, you can add logic here.
if [ -d "$NOTES_SOURCE_DIR" ]; then
    cp -r "$NOTES_SOURCE_DIR"/* "$CONTENT_DIR/" 2>/dev/null || true
fi

# echo "[2/5] Cleaning old generated assets..."
# Remove the output directory if it exists to ensure a fresh build
# rm -rf "$OUTPUT_DIR"

#echo "[2/3] Generating Quartz Site..."
# Run quartz generate. 
# You need node installed. If you are on Obsidian Desktop, run this in VS Code or via CLI terminal.
#cd quartz && npx quartz build -d="$CONTENT_DIR" -o="quartz/public" || { echo "Generation failed. Check console errors."; exit 1; }

echo "[2/2] Pushing to GitHub..."
npx quartz sync

echo "=== Done ==="

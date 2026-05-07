#!/bin/bash

# Directory for images
ASSETS_DIR="public/docs-assets"
mkdir -p "$ASSETS_DIR"

# Input file with unique URLs
URLS_FILE="scratch/imgur_urls.txt"

if [ ! -f "$URLS_FILE" ]; then
    echo "URL list not found at $URLS_FILE"
    exit 1
fi

echo "Starting localization of images..."

while IFS= read -r url; do
    # Extract ID and extension
    # Example: https://i.imgur.com/MDMrqzY.png
    id=$(echo "$url" | sed 's/.*\///; s/\..*//')
    ext=$(echo "$url" | sed 's/.*\.//')
    
    # If no extension found, default to png
    if [ "$id" == "$ext" ]; then
        ext="png"
    fi
    
    filename="imgur-$id.$ext"
    filepath="$ASSETS_DIR/$filename"
    local_path="/docs-assets/$filename"

    # Download if not already exists
    if [ ! -f "$filepath" ]; then
        echo "Downloading $url -> $filename"
        curl -s -o "$filepath" "$url"
        if [ $? -ne 0 ]; then
            echo "Failed to download $url"
            continue
        fi
    else
        echo "Already exists: $filename"
    fi

    # Replace in content directory
    echo "Replacing $url with $local_path in content/"
    # We use | as delimiter for sed because URLs contain /
    # We use -r for recursive grep to find files containing the URL
    grep -rl "$url" content | xargs -r sed -i "s|$url|$local_path|g"

done < "$URLS_FILE"

echo "Localization complete!"

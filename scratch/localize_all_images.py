import os
import re
import requests
import uuid
from urllib.parse import urlparse

# Configuration
DOCS_DIR = 'content/docs'
ASSETS_DIR = 'public/docs-assets'
USER_AGENT = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36'

if not os.path.exists(ASSETS_DIR):
    os.makedirs(ASSETS_DIR)

# Regex to find Markdown images and HTML images
# 1. ![alt](url)
# 2. <img ... src="url" ... />
MD_IMAGE_REGEX = r'!\[([^\]]*)\]\((https?://[^\s)]+)\)'
HTML_IMAGE_REGEX = r'<img[^>]+src=["\'](https?://[^"\']+)["\'][^>]*>'

def download_image(url):
    try:
        # Generate a unique name based on URL hash or original filename
        parsed_url = urlparse(url)
        ext = os.path.splitext(parsed_url.path)[1]
        if not ext or len(ext) > 5:
            ext = '.png' # Default to png if no extension found
            
        # For GitHub assets, they often don't have extensions in the URL
        if 'github.com' in url and '/assets/' in url:
            ext = '.png'

        filename = f"ext-{uuid.uuid4().hex[:8]}{ext}"
        filepath = os.path.join(ASSETS_DIR, filename)
        
        print(f"Downloading {url} -> {filename}")
        headers = {'User-Agent': USER_AGENT}
        response = requests.get(url, headers=headers, timeout=15)
        response.raise_for_status()
        
        with open(filepath, 'wb') as f:
            f.write(response.content)
            
        return f"/docs-assets/{filename}"
    except Exception as e:
        print(f"Error downloading {url}: {e}")
        return None

def process_file(file_path):
    with open(file_path, 'r', encoding='utf-8') as f:
        content = f.read()
    
    new_content = content
    modified = False
    
    # Process Markdown images
    matches = re.findall(MD_IMAGE_REGEX, content)
    for alt, url in matches:
        # Skip local images or already processed ones
        if not url.startswith('http'):
            continue
        
        # Check if it's an image extension or a known image host
        if any(ext in url.lower() for ext in ['.jpg', '.jpeg', '.png', '.gif', '.webp', '.svg']) or \
           any(host in url.lower() for host in ['github.com/user-attachments', 'github.com/erpcya/docs/assets', 'user-images.githubusercontent.com', 'i.imgur.com', 'thefactoryhka.com']):
            
            local_path = download_image(url)
            if local_path:
                new_content = new_content.replace(url, local_path)
                modified = True

    # Process HTML images
    html_matches = re.findall(HTML_IMAGE_REGEX, content)
    for url in html_matches:
        if not url.startswith('http'):
            continue
            
        local_path = download_image(url)
        if local_path:
            new_content = new_content.replace(url, local_path)
            modified = True
            
    if modified:
        with open(file_path, 'w', encoding='utf-8') as f:
            f.write(new_content)
        print(f"Updated {file_path}")

def main():
    for root, dirs, files in os.walk(DOCS_DIR):
        for file in files:
            if file.endswith(('.md', '.mdx')):
                process_file(os.path.join(root, file))

if __name__ == "__main__":
    main()

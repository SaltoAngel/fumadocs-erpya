import os
import re

def sanitize_content(content):
    # 1. Fix Concha -> shell (Case insensitive)
    content = re.sub(r'```[Cc]oncha', '```shell', content)
    
    # 2. Fix backslashes in image paths (Markdown style: ![alt](path))
    def fix_md_image(match):
        return match.group(0).replace('\\', '/')
    
    content = re.sub(r'!\[.*?\]\(.*?\)', fix_md_image, content)
    
    # 3. Fix HTML image paths (src="path")
    def fix_html_src(match):
        return match.group(0).replace('\\', '/')
    
    content = re.sub(r'src=".*?"', fix_html_src, content)

    # 4. Remove trailing backslashes at end of lines
    content = re.sub(r'\\\s*$', '', content, flags=re.MULTILINE)
    
    return content

def run_cleanup():
    content_dir = './content'
    for root, dirs, files in os.walk(content_dir):
        for file in files:
            if file.endswith(('.md', '.mdx')):
                filepath = os.path.join(root, file)
                try:
                    with open(filepath, 'r', encoding='utf-8') as f:
                        content = f.read()
                    
                    new_content = sanitize_content(content)
                    
                    if new_content != content:
                        with open(filepath, 'w', encoding='utf-8') as f:
                            f.write(new_content)
                        print(f"Sanitized: {filepath}")
                except Exception as e:
                    print(f"Error in {filepath}: {e}")

if __name__ == "__main__":
    run_cleanup()

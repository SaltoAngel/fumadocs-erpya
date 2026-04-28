import os
import re

def fix_content(content, filepath):
    # 1. Fix code block language aliases
    content = re.sub(r'```shel\b', '```shell', content)
    
    # 2. Fix Custom Containers (::: tip -> <Callout type="tip">)
    container_map = {
        'tip': 'tip',
        'info': 'info',
        'warning': 'warn',
        'danger': 'error',
        'note': 'info',
        'important': 'warn'
    }
    
    # regex for ::: type [title]
    def replace_container_open(match):
        ctype = match.group(1).lower()
        title = match.group(2) if match.group(2) else ""
        f_type = container_map.get(ctype, 'info')
        if title:
            return f'<Callout type="{f_type}" title="{title.strip()}">\n'
        return f'<Callout type="{f_type}">\n'

    content = re.sub(r':::\s*(\w+)(.*)', replace_container_open, content)
    content = content.replace(':::', '</Callout>')

    # 3. Handle Vue-Demo (custom VuePress thing)
    content = re.sub(r'<Callout type="vue-demo"(.*)>', r'<Callout type="info" title="Demo"\1>', content)

    # 4. Ensure Frontmatter Title
    if not content.startswith('---'):
        # No frontmatter at all
        title_match = re.search(r'^#\s+(.*)', content, re.MULTILINE)
        title = title_match.group(1).strip() if title_match else os.path.basename(filepath).replace('.md', '').replace('.mdx', '').replace('-', ' ').title()
        content = f"---\ntitle: {title}\n---\n\n" + content
    else:
        # Check if title exists in frontmatter
        fm_end = content.find('---', 3)
        if fm_end != -1:
            fm = content[3:fm_end]
            if 'title:' not in fm:
                title_match = re.search(r'^#\s+(.*)', content[fm_end:], re.MULTILINE)
                title = title_match.group(1).strip() if title_match else os.path.basename(filepath).replace('.md', '').replace('.mdx', '').replace('-', ' ').title()
                new_fm = f"title: {title}\n" + fm
                content = content[:3] + new_fm + content[fm_end:]

    return content

def migrate_directory(base_path):
    for root, dirs, files in os.walk(base_path):
        for file in files:
            if file.endswith(('.md', '.mdx')):
                filepath = os.path.join(root, file)
                try:
                    with open(filepath, 'r', encoding='utf-8') as f:
                        content = f.read()
                    
                    new_content = fix_content(content, filepath)
                    
                    if new_content != content:
                        with open(filepath, 'w', encoding='utf-8') as f:
                            f.write(new_content)
                        print(f"Fixed: {filepath}")
                except Exception as e:
                    print(f"Error processing {filepath}: {e}")

if __name__ == "__main__":
    content_dir = "./content"
    migrate_directory(content_dir)

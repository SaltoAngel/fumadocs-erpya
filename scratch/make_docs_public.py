import os
import re

DOCS_DIR = 'content/docs'

def process_file(file_path):
    with open(file_path, 'r', encoding='utf-8') as f:
        lines = f.readlines()
    
    if not lines or not lines[0].strip() == '---':
        print(f"Skipping {file_path}: No frontmatter found at start.")
        return

    # Find the end of frontmatter
    end_index = -1
    for i in range(1, len(lines)):
        if lines[i].strip() == '---':
            end_index = i
            break
    
    if end_index == -1:
        print(f"Skipping {file_path}: Unclosed frontmatter.")
        return

    frontmatter = lines[1:end_index]
    rest = lines[end_index:]
    
    # Check if role exists
    role_found = False
    new_frontmatter = []
    
    for line in frontmatter:
        if line.strip().startswith('role:'):
            new_frontmatter.append('role: public\n')
            role_found = True
        else:
            new_frontmatter.append(line)
            
    if not role_found:
        # Insert after title if possible, otherwise at the top
        inserted = False
        for i, line in enumerate(new_frontmatter):
            if line.strip().startswith('title:'):
                new_frontmatter.insert(i + 1, 'role: public\n')
                inserted = True
                break
        if not inserted:
            new_frontmatter.insert(0, 'role: public\n')
            
    # Combine back
    new_lines = [lines[0]] + new_frontmatter + rest
    
    with open(file_path, 'w', encoding='utf-8') as f:
        f.writelines(new_lines)
    # print(f"Updated {file_path}")

def main():
    count = 0
    for root, dirs, files in os.walk(DOCS_DIR):
        for file in files:
            if file.endswith(('.md', '.mdx')):
                process_file(os.path.join(root, file))
                count += 1
    print(f"Processed {count} files.")

if __name__ == "__main__":
    main()

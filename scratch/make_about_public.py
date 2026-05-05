import os
import re

def add_public_role(file_path):
    with open(file_path, 'r', encoding='utf-8') as f:
        content = f.read()

    # Verificar si ya tiene el rol public
    if re.search(r'^role:\s*public\s*$', content, re.MULTILINE):
        print(f"Skipping {file_path} (already public)")
        return

    # Buscar el inicio del frontmatter
    match = re.match(r'^---\s*\n', content)
    if match:
        # Insertar role: public después de la primera línea ---
        new_content = content[:match.end()] + "role: public\n" + content[match.end():]
        with open(file_path, 'w', encoding='utf-8') as f:
            f.write(new_content)
        print(f"Updated {file_path}")
    else:
        print(f"No frontmatter found in {file_path}")

# Directorio base
base_dir = 'content/docs/about'

for root, dirs, files in os.walk(base_dir):
    for file in files:
        if file.endswith('.md') or file.endswith('.mdx'):
            add_public_role(os.path.join(root, file))

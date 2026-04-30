import os
import re

def fix_links(content):
    # Regex para encontrar enlaces de docs.erpya.com
    # Grupo 1: Path (ej: about/standard-procedures/customer-review)
    # Grupo 2: Opcional .html
    # Grupo 3: Opcional #anchor
    pattern = r'https://docs\.erpya\.com/([^ \)]+?)(\.html)?(#[\w-]+)?'
    
    def replace_link(match):
        path = match.group(1)
        anchor = match.group(3) if match.group(3) else ""
        # Retornar la ruta absoluta interna de Fumadocs
        return f"/docs/{path}{anchor}"

    return re.sub(pattern, replace_link, content)

def process_directory(directory):
    for root, dirs, files in os.walk(directory):
        for file in files:
            if file.endswith(('.md', '.mdx')):
                file_path = os.path.join(root, file)
                print(f"Procesando: {file_path}")
                
                with open(file_path, 'r', encoding='utf-8') as f:
                    content = f.read()
                
                new_content = fix_links(content)
                
                if content != new_content:
                    with open(file_path, 'w', encoding='utf-8') as f:
                        f.write(new_content)
                    print(f"  [CORREGIDO] {file_path}")

if __name__ == "__main__":
    docs_dir = "/opt/development/github/fumadocs-erpya/content/docs"
    process_directory(docs_dir)
    print("\n¡Listo! Todos los enlaces de docs.erpya.com han sido convertidos a rutas internas.")

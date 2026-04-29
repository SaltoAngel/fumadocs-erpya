import os
import re
import requests
import uuid
from pathlib import Path

# Configuración
DOCS_DIR = 'content/docs'
ASSETS_DIR = 'public/docs-assets'
GITHUB_TOKEN = os.getenv('GITHUB_TOKEN')

# Patrones de URL de GitHub Assets
GITHUB_ASSET_PATTERN = r'https://github\.com/(?:[a-zA-Z0-9._-]+/[a-zA-Z0-9._-]+/assets/|user-attachments/assets/)([a-f0-9-]+)'

def download_image(url, save_path):
    headers = {}
    if GITHUB_TOKEN:
        headers['Authorization'] = f'token {GITHUB_TOKEN}'
    
    try:
        response = requests.get(url, headers=headers, stream=True, timeout=15)
        if response.status_code == 200:
            # Intentar adivinar la extensión desde el content-type
            content_type = response.headers.get('Content-Type', '')
            ext = '.png' # Default
            if 'image/jpeg' in content_type: ext = '.jpg'
            elif 'image/gif' in content_type: ext = '.gif'
            elif 'image/svg' in content_type: ext = '.svg'
            elif 'image/webp' in content_type: ext = '.webp'
            
            final_path = save_path.with_suffix(ext)
            with open(final_path, 'wb') as f:
                for chunk in response.iter_content(chunk_size=8192):
                    f.write(chunk)
            return final_path.name
        else:
            print(f"❌ Error {response.status_code} al descargar: {url}")
            return None
    except Exception as e:
        print(f"⚠️ Excepción al descargar {url}: {e}")
        return None

def process_files():
    # Asegurar que la carpeta de assets existe
    Path(ASSETS_DIR).mkdir(parents=True, exist_ok=True)
    
    asset_map = {} # Cache para no descargar lo mismo varias veces

    for root, _, files in os.walk(DOCS_DIR):
        for file in files:
            if file.endswith(('.md', '.mdx')):
                file_path = Path(root) / file
                with open(file_path, 'r', encoding='utf-8') as f:
                    content = f.read()
                
                matches = re.findall(GITHUB_ASSET_PATTERN, content)
                if not matches:
                    continue
                
                print(f"🔍 Procesando {file_path} ({len(matches)} imágenes)")
                new_content = content
                
                # Buscar URLs completas basadas en el ID encontrado
                urls = re.findall(r'https://github\.com/[^\s)]+', content)
                
                for url in urls:
                    # Limpiar URL (quitar paréntesis de cierre de markdown si se coló)
                    clean_url = url.rstrip(')')
                    
                    if 'assets/' in clean_url:
                        if clean_url in asset_map:
                            local_name = asset_map[clean_url]
                        else:
                            # Generar un nombre basado en el ID de la URL o un UUID
                            asset_id = clean_url.split('/')[-1]
                            local_name = download_image(clean_url, Path(ASSETS_DIR) / asset_id)
                            if local_name:
                                asset_map[clean_url] = local_name
                        
                        if local_name:
                            # Reemplazar por la ruta relativa para el navegador
                            new_content = new_content.replace(clean_url, f'/docs-assets/{local_name}')
                
                if new_content != content:
                    with open(file_path, 'w', encoding='utf-8') as f:
                        f.write(new_content)
                    print(f"✨ Actualizado: {file_path}")

if __name__ == "__main__":
    print("🚀 Iniciando descarga de assets de GitHub...")
    process_files()
    print("✅ Proceso completado.")

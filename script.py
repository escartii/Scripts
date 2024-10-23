import os
import re
import shutil

def rename_files_in_directory(directory, target_directory):
    if not os.path.exists(target_directory):
        os.makedirs(target_directory)

    for root, dirs, files in os.walk(directory):
        # Mantener la estructura de carpetas
        relative_path = os.path.relpath(root, directory)
        new_dir_path = os.path.join(target_directory, relative_path)
        if not os.path.exists(new_dir_path):
            os.makedirs(new_dir_path)
        
        for file_name in files:
            # Utilizamos una expresión regular para encontrar los números al principio y el nombre
            match = re.match(r"(\d+)[\W_]*(\w+)\.png", file_name)
            if match:
                numbers = match.group(1)  # Captura los números
                name = match.group(2)  # Captura el nombre (solo palabras)
                
                # Crear nuevo nombre con el formato correcto
                new_name = f"{numbers} {name}.png"
            else:
                # Si no hay coincidencia con la expresión regular, se mantiene el nombre original
                new_name = file_name

            old_file_path = os.path.join(root, file_name)
            new_file_path = os.path.join(new_dir_path, new_name)
            
            # Copiar el archivo, ya sea renombrado o no
            shutil.copy2(old_file_path, new_file_path)
            
            # Mostrar tick verde después del copiado/renombramiento exitoso
            if old_file_path != new_file_path:
                print(f"Archivo movido: {old_file_path} -> {new_file_path} ✔️")
            else:
                print(f"Archivo ya correcto: {old_file_path} -> {new_file_path} ✔️")

# Ruta original de las fotos
directory_path = './'
# Ruta de la carpeta donde se guardarán las fotos renombradas
target_directory = 'fotos_cambiadas'

rename_files_in_directory(directory_path, target_directory)

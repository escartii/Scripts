#!/bin/bash

# Variables de configuración
DB_NAME="wordpress_db"
DB_USER="alumno"
DB_PASSWORD="alumno"
WP_FOLDER="/Applications/xampp/htdocs/mi-wordpress"

# Descargar la última versión de WordPress
echo "Descargando la última versión de WordPress..."
wget https://wordpress.org/latest.tar.gz -O wordpress-latest.tar.gz

# Extraer el archivo descargado
echo "Extrayendo WordPress..."
tar -xzf wordpress-latest.tar.gz

# Mover WordPress a la carpeta de XAMPP
echo "Moviendo WordPress a $WP_FOLDER..."
mv wordpress "$WP_FOLDER"

# Crear archivo de configuración de WordPress
echo "Configurando wp-config.php..."
cp "$WP_FOLDER/wp-config-sample.php" "$WP_FOLDER/wp-config.php"

# Reemplazar la configuración de la base de datos en wp-config.php
sed -i '' "s/database_name_here/$DB_NAME/" "$WP_FOLDER/wp-config.php"
sed -i '' "s/username_here/$DB_USER/" "$WP_FOLDER/wp-config.php"
sed -i '' "s/password_here/$DB_PASSWORD/" "$WP_FOLDER/wp-config.php"

# Crear base de datos
echo "Creando base de datos '$DB_NAME' con usuario '$DB_USER' y contraseña '$DB_PASSWORD'..."
/Applications/xampp/xamppfiles/bin/mysql -u root -p -e "CREATE DATABASE IF NOT EXISTS $DB_NAME;"
/Applications/xampp/xamppfiles/bin/mysql -u root -p -e "GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'localhost' IDENTIFIED BY '$DB_PASSWORD';"
/Applications/xampp/xamppfiles/bin/mysql -u root -p -e "FLUSH PRIVILEGES;"

# Limpiar archivos temporales
echo "Limpiando archivos temporales..."
rm wordpress-latest.tar.gz

echo "WordPress ha sido instalado exitosamente en $WP_FOLDER."
echo "Puedes acceder a la instalación desde: http://localhost/mi-wordpress"

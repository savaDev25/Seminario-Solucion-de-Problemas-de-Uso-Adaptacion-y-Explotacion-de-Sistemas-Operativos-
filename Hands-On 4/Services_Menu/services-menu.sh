#!/bin/bash

# Variable para manejar el menú
menu_option=0

# Función para listar el contenido de un fichero
function list_content() {
    echo "Introduce el nombre o la ubicación del fichero a listar:"
    read folder_name
    if [ -d "$folder_name" ]; then
        ls "$folder_name"
    else
        echo "El fichero no existe."
    fi
}

# Función para crear un archivo de texto
function create_text_file() {
    echo "Introduce el nombre del archivo de texto a crear:"
    read file_name
    if [ -e "$file_name" ]; then
        echo "El archivo ya existe."
    else
        touch "$file_name"
        echo "Introduce el texto que deseas escribir en el archivo:"
        read text_content
        echo "$text_content" > "$file_name"
        echo "El archivo ha sido creado y el texto ha sido escrito en él."
    fi
}

# Función para comparar archivos
function comparate_files() {
    echo "Introduce el nombre o ubicacion del primer archivo:"
    read file1
    echo "Introduce el nombre o ubicacion del segundo archivo:"
    read file2
    if [ -f "$file1" ] && [ -f "$file2" ]; then
        diff "$file1" "$file2"
    else
        echo "Uno o ambos archivos no existen."
    fi
}

# Función de cifrado César con awk
function cypher_file() {
    echo "Introduce el nombre o ubicacion del archivo a cifrar:"
    read file
    echo "Introduce el número para realizar el desplazamiento:"
    read number
    if [ -f "$file" ]; then
        # Procesa el archivo con awk
        awk -v shift="$number" '
        {
            for (i = 1; i <= length($0); i++) {
                char = substr($0, i, 1);
                if (char ~ /[A-Za-z]/) {
                    base = (char ~ /[A-Z]/) ? 65 : 97;
                    printf "%c", ( ( (ord(char) - base + shift) % 26 ) + base );
                } else {
                    printf "%c", char;
                }
            }
            printf "\n";
        }
        function ord(c) {
            return index("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz", c) - 1;
        }' "$file" > "${file}_cifrado"

        echo "El archivo ha sido cifrado y se guardo como '${file}_cifrado'."
    else
        echo "El archivo no existe."
    fi
}

# Función para buscar scripts bash
function find_bash_scripts() {
    echo "Introduce el directorio donde deseas buscar (por defecto '/'):"
    read directory
    directory=${directory:-"/"}
    echo "Buscando archivos que comienzan con '#!/bin/bash' en $directory..."
    grep -rl "^#!/bin/bash" "$directory" 2>/dev/null
}

# Menú de opciones
function menu() {
    case $1 in
        1)
            list_content
            ;;
        2)
            create_text_file
            ;;
        3)
            comparate_files
            ;;
        4)
            cypher_file
            ;;
        5)
            find_bash_scripts
            ;;
        6)
            echo "Saliendo del programa..."
            ;;
        *)
            echo "Opcion no valida. Por favor selecciona otra opcion."
            ;;
    esac
}

# Haciendo el menú persistente
while [ "$menu_option" != 6 ]; do
    echo "Menu de opciones"
    echo -e "\t 1.- Listar el contenido en un fichero"
    echo -e "\t 2.- Crear un archivo de texto"
    echo -e "\t 3.- Comparar dos archivos de texto"
    echo -e "\t 4.- Cifrar archivo con Cesar (awk)"
    echo -e "\t 5.- Buscar bash scripts en un directorio (grep)"
    echo -e "\t 6.- Salir"
    read menu_option
    menu "$menu_option"
done
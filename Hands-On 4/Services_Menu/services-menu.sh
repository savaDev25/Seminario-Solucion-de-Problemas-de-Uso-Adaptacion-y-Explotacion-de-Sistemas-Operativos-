#!/bin/bash

#Variable para manejar el menu
menu_option = 0

#Creando una funcion para listar el contenido de un fichero
function list_content(){
    echo "Introduce el nombre o la ubicacion del fichero a listar:"
    read folder_name
    if [ -d "$folder_name" ]; then
        ls "$folder_name"
    else
        echo "El fichero no existe."
    fi
}

#Creando una funcion para crear un archivo de texto
function create_text_file(){
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
#Creando una funcion para comparar archivos
function comparate_files(){
    echo "Introduce el nombre del o ubicacion del primer archivo:"
    read file1
    echo "Introduce el nombre del o ubicacion del segundo archivo:"
    read file2
    if [ -f "$file1" ] && [ -f "$file2" ]; then
        diff "$file1" "$file2"
    else
        echo "Uno o ambos archivos no existen."
    fi
}

#Creando funcion de cifrado cesar con awk
function cypher_file(){
    echo "Indtroduce el nombre o ubicacion del archivo a cifrar:"
    read file
    echo "Introduce el numero para realizar el desplazamiento:"
    read number
    if [-f "$file"]; then
         # Procesa el archivo con awk
        awk -v shift="$number" '
        {
            for (i = 1; i <= length($0); i++) {
                char = substr($0, i, 1);
                if (char ~ /[A-Za-z]/) {
                    base = (char ~ /[A-Z]/) ? "A" : "a";
                    printf "%c", ( ( (ord(char) - ord(base) + shift) % 26 ) + ord(base) );
                } else {
                    printf "%c", char;
                }
            }
            printf "\n";
        }
        function ord(c) {
            return index("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ", c);
        }' "$file" > "${file}_cifrado"
        
        echo "El archivo ha sido cifrado y se guardó como '${file}_cifrado'."
    else
        echo "El archivo no existe"
    fi
}

function find_bash_scripts() {
    echo "Introduce el directorio donde deseas buscar (por defecto '/'):"
    read directory

    # Si no se especifica un directorio, se utiliza '/' como predeterminado
    directory=${directory:-"/"}

    echo "Buscando archivos que comienzan con '#!/bin/bash' en $directory..."
    
    # Realiza la búsqueda
    grep -rl "^#!/bin/bash" "$directory" 2>/dev/null

    if [ $? -eq 0 ]; then
        echo "Búsqueda completada."
    else
        echo "No se encontraron archivos o hubo un error durante la búsqueda."
    fi
}

#Creando una funcion para el menu
function menu(option_m){
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
            echo "Opción no válida. Por favor selecciona otra opción."
            ;;
    esac
}

#Haciendo el menu persistente
while [$menu_option != 6 ]
do
    #Mostrando el menu de opciones
    echo "Menu de opciones"
    echo "\t 1.-Listar el contenido en un fichero"
    echo "\t 2.-Crear un archivo de texto"
    echo "\t 3.-Comparar dos archivos de texto"
    echo "\t 4.-Cifrar archivo con Cesar (awk)"
    echo "\t 5.-Buscar bash scripts en un directorio(grep)"
    echo "\t 6.-Salir"
    read menu_option
    menu($menu_option)
done    
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
    echo "Introduce el nombre del primer archivo:"
    read file1
    echo "Introduce el nombre del segundo archivo:"
    read file2
    if [ -f "$file1" ] && [ -f "$file2" ]; then
        diff "$file1" "$file2"
    else
        echo "Uno o ambos archivos no existen."
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
    echo "\t 4.-"
    echo "\t 5.-"
    echo "\t 6.-Salir"
    read menu_option
    menu($menu_option)
done    
#!/bin/bash

#Creando un archivo de texto llamado "mytext"
touch mytext
echo "Se ha creado el archivo mytext"


#Agregando la cadena "Hola Mundo" al archivo mytext
echo "Hola Mundo" > mytext
echo "Se ha escrito en mytext"


#Imprimiendo el contendio del archivo mytext
echo "Contenido de mytext:"
echo mytext


#Creando un fichero llamado "backup"
mkdir backup
echo "Se ha creado el fichero backup"


#Moviendo el archivo mytext a backup
mv mytext backup/
echo "Se ha movido el archivo mytext"


#Listando el contenido de backup
echo "Contenido de backup:"
ls backup -la


#Eliminando el archivo mytext
rm backup/mytext
echo "Se ha eliminado mytext"


#Eliminado el fichero backup
rmdir backup
echo "Se ha eliminado el fichero backup"

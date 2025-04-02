#!/bin/bash

#Imprimiendo un hello world en pantalla
echo "Hello World"

#Listando el contenido del fichero actual
echo "Contenido del directorio actual:"
ls -la

#Crear un fichero con el nombre "Test"
mkdir Test
echo "El fichero Test ha sido creado"

#Cambiarse al fichero Test
cd Test
echo "Ahora en Test"

#Listar el contenido del fichero "Test"
echo "Contenido de Test"
ls Test -la


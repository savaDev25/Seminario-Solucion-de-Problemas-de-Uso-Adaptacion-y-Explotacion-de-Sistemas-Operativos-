#!/bin/bash

#Imprimiendo un hello world en pantalla
echo "Hello World"

#Listando el contenido del fichero actual
echo "Contenido del directorio actual:"
ls -la
pause

#Crear un fichero con el nombre "Test"
mkdir Test
echo "El fichero Test ha sido creado"
pause

#Cambiarse al fichero Test
cd  Test
mkdir "Ahora en Test"
pause

#Listar el contenido del fichero "Test"
echo "Contenido de Test"
ls Test -la
pause

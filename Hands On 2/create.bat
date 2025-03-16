@echo off

REM Creando un archivo plano "mytext.txt" y escribiendo "Hola Mundo" en el
type nul > mytext.txt
echo "mytext.txt ha sido creado"
pause

echo "Hola Mundo" >> mytext.txt
echo "Escritura completada"
pause

REM Imprimir el contenido de "mytext.txt"
type mytext.txt
pause

REM Creando un subdirectorio "backup"
mkdir backup
echo "Carpeta creada"
pause

REM Copiando mytext.txt a backup
move mytext.txt backup

REM Listando el contenido de backup
dir backup

REM Eliminar el archivo mytext.txt de backup
del backup\mytext.txt
echo "Eliminacion completa"
pause

REM Eliminar backup
rmdir backup
echo "Eliminacion comleta"
pause
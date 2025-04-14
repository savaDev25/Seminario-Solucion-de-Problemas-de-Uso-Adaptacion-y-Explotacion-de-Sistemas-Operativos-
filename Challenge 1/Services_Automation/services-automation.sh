#!/bin/bash

#Funcion para preguntarle al usuario los datos necesarios para la creacion de la base de datos
function ask_data(){
    echo "Creacion de una maquina virtual"
    
    echo "Introduce el nombre de la maquina virtual"
    read machine_name

    echo "Introduce el tipo de sistema operativo"
    read os_type

    echo "Introduzca la cantidad de CPU's"
    read cpu_number
    
    echo "Introduzca la cantidad de RAM deseada, en Gigabytes"
    read ram_capacity

    echo "Introduzca la cantidad de VRAM deseada, en Megabytes"
    read vram_capacity

    echo "Introduzca la capacidad del disco duro, en Gigabyte"
    read hard_drive_capacity

    echo "Introduzca el nombre del controlador SATA"
    read sata_name

    echo "Introduzca el nombre del controlador IDE"
    read ide_name

    ram_mb=$((ram_capacity * 1024))
    hard_drive_mb=$((hard_drive_capacity * 1024))
    hard_drive_path="$HOME/VirtualMachines/$machine_name/${machine_name}_disk.vdi"

    mkdir -p "$HOME/VirtualMachines/$machine_name"
    echo -e "\n\n"
}

#Funcion para crear y configurar la maquina virtual
function create_and_configurate_vm(){
    #Creando una maquina virtual
    VBoxManage createvm --name "$machine_name" --ostype "$os_type" --register
    #Configurando los parametros de la maquina virtual
    VBoxManage modifyvm "$machine_name" --cpus "$cpu_number" --memory "$ram_mb" --vram "$vram_capacity"
    #Configurando la red NAT para la maquina virtual
    VBoxManage modifyvm "$machine_name" --nic1 nat
    #Creando y asignando el disco duro
    VBoxManage createhd --filename "$hard_drive_path" --size "$hard_drive_mb" --variant Standard
    #Creando y configurando el controlador SATA
    VBoxManage storagectl "$machine_name" --name "$sata_name" --add sata --bootable on
    VBoxManage storageattach "$machine_name" --storagectl "$sata_name" --port 0 --device 0 --type hdd --medium "$hard_drive_path"
    #Creando y configurando el controlador IDE
    VBoxManage storagectl "$machine_name" --name "$ide_name" --add ide 

    echo -e "\n\n"
}

#Funcion para mostrar la configuracion final
function show_configuration(){
    echo -e "Configuracion final:\n"
    VBoxManage showvminfo "$machine_name" --machinereadable | grep -E 'name|ostype|memory|vram|cpus|storagecontroller|sata|ide|medium|nic1|bridgeadapter1'
    echo -e "\nEl proceso para la '$machine_name' ha sido completado con exito"
}

ask_data
create_and_configurate_vm
show_configuration



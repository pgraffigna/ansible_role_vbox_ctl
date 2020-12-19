#!/bin/bash

#Colours
greenColour="\e[0;32m\033[1m"
redColour="\e[0;31m\033[1m"
yellowColour="\e[0;33m\033[1m"
blueColour="\e[0;34m\033[1m"
endColour="\033[0m\e[0m"

#Ctrl-C
trap ctrl_c INT
function ctrl_c(){
        echo -e "\n${redColour}Programa Terminado ${endColour}"
        exit 0
}

echo -e "\n${yellowColour}Listando las VMs ${endColour}"
vboxmanage list vms --long | grep -E "Name:|State:"

read -p "$(echo -e "${blueColour}""Elija la VM y el MODO {salvar|iniciar|apagar}: ""${endColour}")" -ra DATOS

case ${DATOS[1]} in
  salvar)
    echo -e "\n${greenColour}Parando y salvando el estado de $VM...${endColour}"
    VBoxManage controlvm "${DATOS[0]}" savestate
    ;;
  iniciar)
    echo -e "\n${greenColour}Iniciando $VM...${endColour}"
    VBoxManage startvm "${DATOS[0]}" --type=headless
    ;;
  apagar)
    echo -e "\n${redColour}Apagando $VM...${endColour}"
    VBoxManage controlvm "${DATOS[0]}" poweroff
    ;;
  *)
    echo -e "\n${blueColour}Modo de uso: nombre_VM {salvar|iniciar|apagar} ${endColour}"
    ;;
esac
 

#!/bin/bash

USUARIO_BASE=$1
LISTA=$2

CLAVE=$(sudo grep -i "$USUARIO_BASE" /etc/shadow | awk -F ':' '{print $2}')

SEPARADOR=$'\n'
for LINEA in $(grep -v ^# "$LISTA"); do
    USUARIO=$(echo "$LINEA" | awk -F ',' '{print $1}')
    GRUPO=$(echo "$LINEA" | awk -F ',' '{print $2}')
    HOME_DIR=$(echo "$LINEA" | awk -F ',' '{print $3}')

    getent group "$GRUPO" > /dev/null || sudo groupadd "$GRUPO"
    sudo useradd -m -d "$HOME_DIR" -s /bin/bash -g "$GRUPO" -p "$CLAVE" "$USUARIO"
done
unset SEPARADOR


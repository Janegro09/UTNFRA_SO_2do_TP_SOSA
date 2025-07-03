#!/bin/bash

fdisk /dev/sdb <<EOF
n
p
1


t
8e
w
EOF

fdisk /dev/sdc <<EOF
n
p
1


t
8e
w
EOF

pvcreate /dev/sdb1
pvcreate /dev/sdc1

vgcreate vg_datos /dev/sdb1
vgcreate vg_temp /dev/sdc1

lvcreate -L 5M -n lv_docker vg_datos
lvcreate -L 1.5G -n lv_workareas vg_datos
lvcreate -L 512M -n lv_swap vg_temp

mkfs.ext4 /dev/vg_datos/lv_docker
mkfs.ext4 /dev/vg_datos/lv_workareas

mkswap /dev/vg_temp/lv_swap
swapon /dev/vg_temp/lv_swap

mkdir -p /work/

mount /dev/vg_datos/lv_docker /var/lib/docker/
mount /dev/vg_datos/lv_workareas /work/

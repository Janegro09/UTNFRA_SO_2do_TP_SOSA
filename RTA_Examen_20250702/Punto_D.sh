#!/bin/bash

cd ~/UTN-FRA_SO_Examenes/202406/ansible/roles/2do_parcial/tasks/

cat > main.yml <<EOF
---
- name: "Crear directorios en /tmp/2do_parcial/"
  file:
    path: "/tmp/2do_parcial/{{ item }}"
    state: directory
    mode: '0755'
  loop:
    - "alumno"
    - "equipo"

- name: "Agregar archivo desde template alumno.j2"
  template:
    src: alumno.j2
    dest: /tmp/2do_parcial/alumno/datos_alumno.txt
    mode: '0644'

- name: "Agregar archivo desde template equipo.j2"
  template:
    src: equipo.j2
    dest: /tmp/2do_parcial/equipo/datos_equipo.txt
    mode: '0644'

- name: "Agregar NOPASSWD para grupo 2PSupervisores"
  become: yes
  lineinfile:
    path: /etc/sudoers
    state: present
    line: '%2PSupervisores ALL=(ALL) NOPASSWD: ALL'
    validate: 'visudo -cf %s'
EOF

cd ..
mkdir -p templates
cd templates

cat > alumno.j2 <<EOF
nombre: Javier
apellido: Sosa
division: 117
EOF

cat > equipo.j2 <<EOF
ip: {{ ansible_default_ipv4.address }}
distribucion: {{ ansible_distribution }}
cantidad de cores: {{ ansible_processor_cores }}
EOF

cd ~/UTN-FRA_SO_Examenes/202406/ansible/
ansible-playbook -i inventory/hosts playbook.yml

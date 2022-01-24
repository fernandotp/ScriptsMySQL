#!/bin/bash

# Este script realiza una copia de seguridad de cada una de las bases de datos existentes en MySQL

DIRBACKUPS=/root/backups/mysql

#Informacion de logueo
USER="root"		# Nombre de usuario
PASS=' '	# Contrasena
HOST="localhost"	# Host

MYSQL="$(which mysql)"


[ ! -d "${DIRBACKUPS}" ] && mkdir -p "${DIRBACKUPS}"

# Obtener los nombres de todas las bases de datos
BBDDS="$($MYSQL --login-path=local -Bse 'show databases')"

#BBDDS="$($MYSQL -u $USER -h $HOST -p $PASS -Bse 'show databases')"
echo -e "\nRealizando backups de MySQL..."
for bbdd in $BBDDS
do
	./backupBBDD.sh $USER $bbdd
done

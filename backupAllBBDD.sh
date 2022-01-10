#!/bin/bash

# Este script realiza una copia de seguridad de cada una de las bases de datos existentes en MySQL

TODAY=`date '+%Y_%m_%d__%H_%M_%S'`;
DIRBACKUPS="/.backup/mysql"

#Informacion de logueo
USER="root"		# Nombre de usuario
PASS=' '		# Contrasena
#HOST="127.0.0.1"	# Host
HOST="localhost"	# Host

# guess binary names
MYSQL="$(which mysql)"
MYSQLDUMP="$(which mysqldump)"
GZIP="$(which gzip)"

[ ! -d "${DIRBACKUPS}" ] && mkdir -p "${DEST}"

# Obtener los nombres de todas las bases de datos
BBDDS="$($MYSQL -u $USER -h $HOST -p $PASS -Bse 'show databases')"
for bbdd in $BBDDS
do
	echo $bbdd
	#FILE=${DEST}/mysql-${db}.${NOW}-$(date +"%T").gz
	# get around error
	#$MYSQLDUMP --single-transaction -u $MUSER -h $MHOST -p$MPASS $db | $GZIP -9 > $FILE
done

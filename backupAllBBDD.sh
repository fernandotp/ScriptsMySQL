#!/bin/bash

# Este script realiza una copia de seguridad de cada una de las bases de datos existentes en MySQL

TODAY=`date '+%Y_%m_%d__%H_%M_%S'`;
DIRBACKUPS=/root/backups/mysql

#Informacion de logueo
USER="root"		# Nombre de usuario
PASS=' '		# Contrasena
HOST="localhost"	# Host

MYSQL="$(which mysql)"
MYSQLDUMP="$(which mysqldump)"
GZIP="$(which gzip)"

[ ! -d "${DIRBACKUPS}" ] && mkdir -p "${DIRBACKUPS}"

# Obtener los nombres de todas las bases de datos
BBDDS="$($MYSQL -u $USER -h $HOST -p $PASS -Bse 'show databases')"
echo -e "\nRealizando backups de MySQL..."
for bbdd in $BBDDS
do
	echo $bbdd
	NOMBREBACKUP=${DIRBACKUPS}/mysql-${db}.${NOW}-$(date +"%T").gz
	./backupBBDD.sh $USER $bbdd
	#mysqldump --user=$USER --password=$PASS --host=$HOST $bbdd > $DIRBACKUPS/$NOMBREBACKUP
	#$MYSQLDUMP --single-transaction -u $MUSER -h $MHOST -p$MPASS $db | $GZIP -9 > $FILE
done

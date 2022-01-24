#!/bin/bash

declare -A nombresBBDD
DIRBACKUPS=/root/backups/mysql

#Informacion de logueo
USER="root"		# Nombre de usuario
PASS=' '	# Contrasena
HOST="localhost"	# Host

MYSQL="$(which mysql)"

	[ ! -d "${DIRBACKUPS}" ] && mkdir -p "${DIRBACKUPS}"
	if [ "$(ls $DIRBACKUPS)" ]
	then
		BBDDS="$($MYSQL -u $USER -h $HOST -p $PASS -Bse 'show databases')"

		echo -e "\n--------------- Espacio file system backups ---------------"
		fileSystemBackups=$(df -T $DIRBACKUPS)
		echo "$fileSystemBackups"
		
		for i in $BBDDS
		do
		if [[ ("$i" != "information_schema") && ("$i" != "datname")]];
		then	
			ultimoBackup=$(find $DIRBACKUPS -name "*$i*" -type f -mtime -32 | tail -1)

			if [ "$ultimoBackup" ]
			then
				tamanoUltimoBck=$(du -sh $ultimoBackup)
				echo -e "\nTamaño del ultimo backup de $i: $tamanoUltimoBck\n"
			else
				echo -e "\nNo existe ningun backup de $i\n"
			fi
		fi
		done
	else	
		echo -e "\nEl directorio de backups está vacio\n"

	fi

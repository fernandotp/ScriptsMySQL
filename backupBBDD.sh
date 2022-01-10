#!/bin/bash
dirBackups=/home/fernando/backupsmysql

if [[ (-n "$1") && (-n "$2") ]];
then
	echo -e "\nRealizando backup de $2..."
	today=`date '+%Y_%m_%d__%H_%M_%S'`;
	nombreBackup="backup_$2_$today.sql"

		#------------REALIZAR BACKUP--------------

	ultimoBackup=$(find $dirBackups -name "*_$2_*" -type f -mtime -9 | tail -1)
	tamanoUltimoBck=$(du -sh $ultimoBackup)
	mysqldump --user=$1 --password="" --host=localhost $2 > $dirBackups/$nombreBackup
	tamanoNuevoBck=$(du -sh  $dirBackups/$nombreBackup)
	bckVacio=${tamanoNuevoBck:0:1}

	if [ $bckVacio -eq 0 ]
	then
		echo -e "\nError. No se pudo realizar el backup de $2\n"
		rm $dirBackups/$nombreBackup
	else
		FICHERO=$dirBackups/$nombreBackup
		cd  $dirBackups

		if [ -f $nombreBackup ]
		then
			if [ "$(ls $dirBackups)" ]
			then

				if [ "$ultimoBackup" ]
				then
					echo -e "\nTamaño del ultimo backup de $2: $tamanoUltimoBck\n"
				fi
			fi
			echo -e "\nTamaño del nuevo backup de $2: $tamanoNuevoBck"
			echo ""
			echo "--------------- Espacio file system backups ---------------"
			df -h $dirBackups
			echo ""
		else
 			echo -e "\nERROR. No se pudo realizar el bakup de $2\n"
		fi
	fi
else
	echo -e "\nSe debe especificar el usuario y la base de datos.\nFormato: ./backupBBDD.sh -'usuario' -'Base de datos'\n"
fi

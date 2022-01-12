#!/bin/bash

declare -A nombresBBDD
DIRBACKUPS=/root/backups/mysql

obtenerNombresBBDD(){

	while read -a Datos_Consulta;
	do
		DATO1=${Datos_Consulta}
		let j=j+1
		nombresBBDD[$j]=$DATO1
	done <nombresBBDD.txt
}

mysql -e 'show databases;' > showBBDD.txt
echo "" > nombresBBDD.txt
./listarBBDD showBBDD.txt

	obtenerNombresBBDD
	[ ! -d "${DIRBACKUPS}" ] && mkdir -p "${DIRBACKUPS}"
	if [ "$(ls $DIRBACKUPS)" ]
	then
		echo -e "\n--------------- Espacio file system backups ---------------"
		fileSystemBackups=$(df -T $DIRBACKUPS)
		echo "$fileSystemBackups"
		
		for i in ${nombresBBDD[@]}
		do	
			ultimoBackup=$(find $DIRBACKUPS -name "*$i*" -type f -mtime -32 | tail -1)

			if [ "$ultimoBackup" ]
			then
				tamanoUltimoBck=$(du -sh $ultimoBackup)
				echo -e "\nTamaño del ultimo backup de $i: $tamanoUltimoBck\n"
			else
				echo -e "\nNo existe ningun backup de $i\n"
			fi
		done
	else	
		echo -e "\nEl directorio de backups está vacio\n"

	fi
	rm nombresBBDD.txt

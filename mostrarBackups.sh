
#!/bin/bash

declare -A nombresBBDD

obtenerNombresBBDD(){

	while read -a Datos_Consulta;
	do
		DATO1=${Datos_Consulta}
		let j=j+1
		echo $DATO1
		nombresBBDD[$j]=$DATO1
	done <nombresBBDD.txt
}

mysql -e 'show databases;' > showBBDD.txt
echo "" > nombresBBDD.txt
./listarBBDD showBBDD.txt
obtenerNombresBBDD
rm nombresBBDD.txt

#!/bin/bash

procesosActivos=$(ps -ef | grep mysql | grep /mysqld)
if [ "$procesosActivos" ]
then
	echo -e "\n---------- Procesos activos de MySQL ----------\n"
	echo $procesosActivos
else
	echo -e "\nActualmente no hay ningún proceso de MySQL activo\n"
fi

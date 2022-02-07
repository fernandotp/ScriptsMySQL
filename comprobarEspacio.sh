#!/bin/bash
# Este Script muestra todos los filesystems que tengan un porcentaje de ocupacion mayor al indicado

  numeroLineas=$(df -T | awk '$6>87 { print $0}' | wc -l )
        if [[ $numeroLineas -gt 1 ]];
        then
                df -T | awk '$6>87 { print $0}'
        fi


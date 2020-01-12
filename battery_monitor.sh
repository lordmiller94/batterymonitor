#!/bin/bash
#Monitor de bateria por Nathan Monteiro

#Definindo variáveis do aplicativo

#Tempo de espera (segundos)
waitTime=10

#Pasta do aplicativo
folder=".batterymonitor"
homepath=`echo ~`
completePath="$homepath/$folder"

#Testando a existência da pasta do batterymonitor e criando a pasta do aplicativo na pasta home do usuário

if [ -d "${completePath}" ]
then
	echo "Diretório existente"
else
	mkdir "${completePath}"
fi


#Iniciando o monitoramento
while :
do
	#Definindo a hora atual
	nowTime=`date +%Y/%m/%d\;\%H:%M:%S\;`
	nowDate=`date +%Y-%m-%d`

	#Medindo a porcentagem da bateria
	remainBattery=`acpi -b`
	
	#Cortando a string da bateria (bateria restante)
	remainBattery=${remainBattery#*,}
	remainBattery=${remainBattery%,*}

	#Medindo tempo restante da bateria
	remainTime=`acpi -b`

	#Cortando a string da bateria (tempo restante)
	remainTime=${remainTime#*,}
	remainTime=${remainTime#*,}
	remainTime=`echo ${remainTime}| cut -c1-8`
	
	#Montando a linha
	lineStatus="${nowTime}${remainBattery};${remainTime};"

	#Salvando a linha no arquivo do dia atual
	echo ${lineStatus} >> "${completePath}/$nowDate.csv"
	
	#Descomente o echo abaixo para testar a saída
	echo ${lineStatus}

	sleep ${waitTime}
done

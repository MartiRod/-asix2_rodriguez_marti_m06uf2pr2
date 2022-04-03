#!/bin/bash
#Script 1
#Martí Rodríguez

clear


wget http://www.collados.org/asix2/m06/uf2/usuaris.ods > /dev/null 2>&1	#Descarrega el fixter usuaris.od

if [[ -e usuaris.ods ]]		#He fet aixo per comprobar si s'ha descarregat be pero realment no es necesari per a que funcioni
then
	echo "S'ha descarregat el fitxer"
else
	echo "No s'ha descarregat be el fitxer"
	exit 2
fi


libreoffice --convert-to csv --outdir . usuaris.ods  > /dev/null 2>&1	#ho pasem a csv

if [[ -e usuaris.csv ]]	#Lo mateix per veure si es converteix be o no
then
	echo "Fitxer a CSV"
else
	echo "No s'ha convertit be"
	exit 2
fi

uid=$((3001))	#indiquem amb quin uid te que començar
while read line # bucle on va linea per linea del fitxer fins a arribar a l'ultima
do

	usuari=$(echo $line | cut -d ',' -f2) #Llegeix el csv

	
	useradd  $usuari  -u  $uid  -g  users  -d  /home/$usuari  -m  -s  /bin/bash  -p  $(mkpasswd  clotfje2002) > /dev/null 2>&1
	
	((uid++)) #Sumem a la variable uid un valor per a que no es repeteixi
done < usuaris.csv
	 
echo -n "S'ha finalitzat el script"
exit 0

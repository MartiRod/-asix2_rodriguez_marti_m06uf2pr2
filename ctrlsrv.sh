#!/bin/bash
#
if [ $EUID -ne 0 ]
then
	echo "Cal ser root"
	exit 1
fi

mostra_serveis(){
	clear
	echo "Opcions Disponibles:"
	echo "	1) cups"
	echo "	2) ssh"
	echo "	3) apache2"
	echo ""
	echo -n "Escriu el nom del servei desitjat: "
	read Opcio
}

ctrl_servei(){
	case $Opcio in
		'1')
			systemctl status cups > /dev/null
			if [[ $? -ne 0 ]]
			then
			systemctl start cups
			echo "Iniciant Servei."
			else
			echo "El programa ja estaba iniciat o no existeix."
			fi
			;;
		
		'2')
			systemctl status ssh > /dev/null
			if [[ $? -ne 0 ]]
			then
				systemctl start ssh
				echo "Iniciant Servei."
			else
				echo "El programa ja estaba iniciat o no existeix."
			fi
			;;
		'3')
			systemctl status apache2 > /dev/null
			if [[ $? -ne 0 ]]
			then
				systemctl start apache2
				echo "Iniciant Servei."
			else
				echo "El programa ja estaba iniciat o no existeix."
			fi
			;;
		
		*)
			echo "Opcio no Acceptada. Tancant programa."
			exit 1
	esac
	echo ""
	echo "Finalitzat."
}
##############
mostra_serveis
ctrl_servei
exit 0

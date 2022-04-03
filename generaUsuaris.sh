#!/bin/bash
#
#generaUsuaris.sh
#Marti Rodriguez

clear #Neteja la pantalla

if [[ -e nousUsuaris.ldif ]]  #Aqui comprobo si el fitxer "nousUsuaris" esta creat o no
then
	echo "Borrant nousUsuaris.ldif antic..."
	rm -R nousUsuaris.ldif	#Si esta creat, per a que no es sobreiscribeixen les dades borro l'antic
else
	echo "No existeix el fitxer nousUsuaris.ldif, es creara en aquesta activitat"
fi



while [[ true ]] #Bucle infinit per si poses un valor incorrecte que pugis seguir intentant fins a posar-los be
do
	echo "Numero d'usuaris totals (entre 1 i 100) "
	read Tusuarios
	if ((Tusuarios >=1 && Tusuarios <= 100)) # Comproba que el numero insertat sigui igual o mes gran que 1 i a la vegada que sigui igual o mes petit que 100
	then
		while [[ true ]] 
		do
			echo "Valor uid per usuaris (minim 5000) "
			read uidNumber
			if ((uidNumber >= 5000)) #Te que ser igual o mes gran que 5000
			then
				echo "Es crearán $Tusuarios usuaris" #No fa falta pero ho he posat basicament per mes comoditat
				echo "uid insertat: $uidNumber"
				for (( contador=0; contador<Tusuarios; contador++ )) #Un bucle on es va sumant d'un en un fins a arribar als usuaris que volem crear. 
				do
					#ara inserto dins de nousUsuaris.ldif les dades necesaries per a poder crear un usuari dins de ldpap
					echo "dn: uid=usr$uidNumber,cn=UsuarisDomini,ou=UsuarisGrups,dc=fjeclot,dc=net" >> nousUsuaris.ldif  #Com es un bucle no puc posar només ">" per que cada vegada que es repeteix borraria les dades anteriors, per aixo borro al principi el fitxer per que aixi no es sobreescribeixen sempre les dades
					echo "objectClass: top" >> nousUsuaris.ldif
					echo "objectClass: posixAccount" >> nousUsuaris.ldif
					echo "objectClass: shadowAccount" >> nousUsuaris.ldif
					echo "objectClass: person" >> nousUsuaris.ldif
					echo "uid:usr$uidNumber" >> nousUsuaris.ldif
					echo "gidNumber: 100" >> nousUsuaris.ldif
					echo "loginShell: /bin/bash" >> nousUsuaris.ldif
					echo "cn: usr$uidNumber usr$uidNumber" >> nousUsuaris.ldif
					echo "sn: usr$uidNumber" >> nousUsuaris.ldif
					echo "homeDirectory: /home/usr$uidNumber" >> nousUsuaris.ldif
					echo "" >> nousUsuaris.ldif #Deixo unes lineas en blanc perque sino queda lleig
					echo "" >> nousUsuaris.ldif
					((uidNumber++)) #Sumo la variable uidNumber una unitat així quan el bucle torni a repetir no sera les mateixes dades
				done
				echo "Fitxer nousUsuaris.ldif creat correctament" 
				
				ldapadd -x -W -D "cn=UsuarisDomini,ou=UsuarisGrups,dc=fjeclot,dc=net" -f nousUsuaris.ldif #Comanda per ficar a LDAP els users
		
			break;
			fi
			
		done
	break;		
	fi
	
done





exit 0

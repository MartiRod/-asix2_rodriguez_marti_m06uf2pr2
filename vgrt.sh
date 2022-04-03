#!/bin/bash
# Activitat 7 

echo "# Script 7 per Martí Rodríguez" > VagrantFile		#Poso només un ">" per a que cada vegada que s'executi el script sobreescribi tot lo que habia dins del fitxer per aixi no donar problemes
echo "Vagrant.configure("'"'"2"'"'") do |config|" >> VagrantFile  #Ficar les cometes dobles dins d'un fixter es un infern, cal posar totes aquestes per a que funcioni, pots probar a treure i veuras que no funciona be
echo  "config.vm.box = "'"'"generic/debian10"'"'"" >> VagrantFile
echo "config.vm.hostname = "'"'"maroma"'"'"" >> VagrantFile
echo  "config.vm.provider "'"'"virtualbox"'"'" do |v|"  >> VagrantFile
    # v.gui = true
echo  "v.name = "'"'"Script7Maroma"'"'"" >> VagrantFile
echo    "v.memory = 2048" >> VagrantFile
echo    "v.cpus = 1"  >> VagrantFile
echo    "v.customize ['modifyvm', :id, '--clipboard', 'bidirectional']"  >> VagrantFile     
echo  "end"  >> VagrantFile

echo  "config.vm.network "'"'"forwarded_port"'"'", guest: 80, host: 8000"  >> VagrantFile
echo  "config.vm.network "'"'"forwarded_port"'"'", guest: 443, host: 8080" >> VagrantFile
echo  "config.vm.network "'"'"forwarded_port"'"'", guest: 3306, host: 8888"  >> VagrantFile
echo  "config.vm.network "'"'"forwarded_port"'"'", guest: 22, host: 8808"  >> VagrantFile
  
echo  "config.vm.provision "'"'"shell"'"'", inline: <<-SHELL"  >> VagrantFile
echo    "sudo apt-get update -y"  >> VagrantFile
echo    "sudo apt-get upgrade -y" >> VagrantFile
echo    "sudo apt-get install -y net-tools" >> VagrantFile
echo    "sudo apt-get install -y openssh" >> VagrantFile
echo    "sudo apt-get install -y apache2 apache2-doc" >> VagrantFile
echo "Vols instalar els paquets extra? [s per si, n per No]"		#Aqui pregunto si es volen instalar els paquets extra
read opc
if  [[  $opc  ==  "s" ]]		#Si posa l'user una s posa dins del VagrantFile els comandaments extra
then
echo    "sudo apt-get install -y openssh-sftp-server" >> VagrantFile
echo    "sudo apt-get install -y mariadb-server" >> VagrantFile
echo    "sudo apt-get install -y mariadb-client" >> VagrantFile    
fi

echo  "SHELL" >> VagrantFile

echo "end"  >> VagrantFile


exit 0


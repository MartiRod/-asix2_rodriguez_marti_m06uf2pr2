#!/bin/bash

#Script 2
#Marti Rodriguez


clear
if (( $EUID != 0 )) # Per comprobar que siguis root o no
then
  echo "No ets usuari root"
  exit 1 
fi


filename=$(echo "dhcpd.conf.$(date +"%y%m%d%H%M")")	# Crea el ficher pero amb la data actual


echo -n "Nom del Domini: "
read nomdomini

echo -n "IP del DNS "
read ipdns

echo -n "IP del router "
read iprouter

echo -n "Leasing per defecte: "
read leasingdefecte

echo -n "Leasing maxim: "
read leasingmaxim

echo -n "Ip subxarxa: "
read ip_address

echo -n "Mascara subxarxa: "
read mask_address
echo""
echo "Configurem el rang d'ip del DHCP"
echo -n "Primera adreça IP: "
read ini_dhcp_ip_range
echo""
echo -n "Ultima adreça IP "
read fin_dhcp_ip_range
echo""
echo "copiant dhcp.conf a $filename"
cp /etc/dhcp/dhcpd.conf /etc/dhcp/$filename
echo""
echo "borrant dhcpd.conf"
rm /etc/dhcp/dhcpd.conf
echo""
echo "Creant nou dhcpd.conf"
touch /etc/dhcp/dhcpd.conf
echo""


echo "authoritative;" >> /etc/dhcp/dhcpd.conf
echo "ddns-update-style none;" >> /etc/dhcp/dhcpd.conf
echo "option domain-name \"$nomdomini\";" >> /etc/dhcp/dhcpd.conf
echo "option domain-name-servers $ipdns;" >> /etc/dhcp/dhcpd.conf
echo "option routers $iprouter;" >> /etc/dhcp/dhcpd.conf
echo "default-lease-time $leasingdefecte;" >> /etc/dhcp/dhcpd.conf
echo "max-lease-time $leasingmaxim;" >> /etc/dhcp/dhcpd.conf
echo "subnet $ip_address netmask $mask_address {" >> /etc/dhcp/dhcpd.conf
echo "range $ini_dhcp_ip_range $fin_dhcp_ip_range;" >> /etc/dhcp/dhcpd.conf
echo "}" >> /etc/dhcp/dhcpd.conf
echo""



cat /etc/dhcp/dhcpd.conf
echo""


systemctl restart isc-dhcp-server 2> /dev/null

exit 0

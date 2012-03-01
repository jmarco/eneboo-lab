#!/bin/sh
echo Instalando tomcat y librería vnc
apt-get install tomcat6 libvncserver0 openjdk-6-jdk vnc4server fluxbox
echo Compilando WAR
cd ../guaca-src
jar cvf guaca.war .
echo Borrando WAR viejo
rm ../final/guaca.war
cp guaca.war ../final
cd ../final
echo Listo , ahora a instalar

echo Limpiando ...

rm -R /etc/guacamole
rm -R /var/lib/guacamole
rm -R /var/lib/tomcat6/webapps/gua*
rm /var/lib/tomcat6/common/classes/guacamole.properties
echo Creando estructura ..
mkdir /etc/guacamole
mkdir /var/lib/guacamole
SO=`uname -m`
echo Instalando DEBS $SO

rm ./deb

# Detectamos si es 32 o 64 bits.
if [ $SO = "i686" ]
then
        # 32 bits
        ln -s ./deb32 ./deb


elif [ $SO = "x86_64" ]
then
	#64 bits
        ln -s ./deb64 ./deb

fi
dpkg -i ./deb/*.deb
cp ./guacamole.properties /etc/guacamole/
cp ./user-mapping.xml /etc/guacamole/
chmod 777 /etc/guacamole/user-mapping.xml
cp ./guaca.war /var/lib/guacamole/guaca.war
ln -s /var/lib/guacamole/guaca.war /var/lib/tomcat6/webapps/guaca.war
ln -s /etc/guacamole/guacamole.properties /var/lib/tomcat6/common/classes/
echo Reiniciando Tomcat
/etc/init.d/tomcat6 restart
echo cambiando permisos en traspaso
mkdir /var/lib/tomcat6/webapps/guaca/traspaso
chmod -R 777 /var/lib/tomcat6/webapps/guaca/traspaso
echo Listo. Ahora ejecute uguaca.sh con cada usuario a usar.
echo Listo ...

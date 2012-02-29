#!/bin/sh
clear
if [ $# -ne 3 ]; then echo Faltan Argumentos. Ejemplo:  
echo ./ustorm.sh 1 demo passworddemo
echo  1 .- es el puerto vnc 9501 , 2 sería 9502 ...  
echo demo .- seria usuario login web.
echo passworddemo .- sería password login web.
else
puerto=$(($1+5900))
echo $puerto 
echo Comienza la creación del usuario $2, en canal $1, con el password $3.  

#echo Instalando ejecutable eneboo

echo Creando nueva configuración Escritorio Virtual
rm -R $HOME/.vnc
mkdir $HOME/.vnc
cp ./xstartup $HOME/.vnc/xstartup
chmod 755 $HOME/.vnc/xstartup
echo Por favor introduce esto como password : "'$3'"
echo si no es el mismo en interface no conectaría
vncpasswd
echo Gracias.
echo Configurado usuario en interface web
#echo Sacando copia para trabajar
rm user-mapping.xml.temporal
cat /etc/guacamole/user-mapping.xml | egrep -v "</user-mapping>" > ./user-mapping.xml.temporal
#cat /etc/guacamole/user-mapping.xml | egrep -v "</user-mapping>"
#echo Añadiendo Usuario y password
echo '<authorize username="'$2'" password="'$3'">' >> ./user-mapping.xml.temporal
#echo Añadiendo Protocolo de enlace
echo '<protocol>vnc</protocol>' >> ./user-mapping.xml.temporal
#echo Añadiendo URL Servidor de stream
echo '<param name="hostname">localhost</param>' >> ./user-mapping.xml.temporal
#echo Añadiendo puerto protocolo $puerto
echo '<param name="port">'$puerto'</param>' >> ./user-mapping.xml.temporal
#echo Añadiendo contraseña servidor stream
echo '<param name="password">'$3'</param>' >> ./user-mapping.xml.temporal
#echo Añadiendo fin de configuración de usuario
echo '</authorize>' >> ./user-mapping.xml.temporal
#echo Añadiendo marca fin de fichero
echo "</user-mapping>" >> ./user-mapping.xml.temporal
#echo Sustituyendo fichero con nueva configuración
cat user-mapping.xml.temporal > /etc/guacamole/user-mapping.xml
#echo Borrado fichero temporal
#rm ./user-mapping.xml.temporal
echo Creando enlace a traspaso 
rm -R $HOME/.Guacamole
mkdir /var/lib/tomcat6/webapps/guaca/traspaso/$2
ln -s /var/lib/tomcat6/webapps/guaca/traspaso/$2 $HOME/.Guacamole
echo Listo.Recuerde modificar $HOME/.vnc/xstartup con la ruta correcta del ejecutable eneboo
fi


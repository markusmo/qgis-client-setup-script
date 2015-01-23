#!/bin/bash

sudo apt-get update

#install postgres and postgis
sudo apt-get install -y postgresql postgresql-contrib
sudo apt-get install postgis
sudo apt-get install python-psycopg2

#configure database
echo "Type in your username: "
read user
sudo -u postgres createuser -P $user

echo "Type in your database name: "
read database
sudo -u postgres createdb -O $user $database

#create extension
sudo -u postgres psql -c "CREATE EXTENSION postgis; CREATE EXTENSION postgis_topology;" $database

#install qgis and qgis-server
sudo apt-get install qgis
sudo apt-get install qgis-mapserver
sudo apt-get install python-webob

#install git
sudo apt-get install git

#clone ggis-web-client
git clone https://github.com/qgis/QGIS-Web-Client.git

#install apache and fcgid
sudo apt-get install apache2
sudo apt-get install libapache2-mod-fcgid

#servername, change localhost, if you have any domain names
echo "ServerName localhost" | sudo tee /etc/apache2/conf-available/servername.conf
sudo a2enconf servername
sudo /etc/init.d/apache2 restart

sudo ln -s QGIS-Web-Client/apache-conf/qgis-web-client.conf /etc/apache2/sites-available/qgis-web-client.conf
#sudo mv /etc/apache2/sites-enabled/000-default.conf /etc/apache2/sites-enabled/000-default.conf.old

sudo a2enmod rewrite && sudo a2ensite /etc/apache2/sites-available/qgis-web-client.conf && sudo service /etc/init.d/apache2 restart

#create a new project
echo "Name your new QGIS project: "
read projectname
sudo mkdir /usr/lib/cgi-bin/$projectname

sudo ln -s /usr/lib/cgi-bin/qgis_mapserv.fclocagi /usr/lib/cgi-bin/$projectname/qgis_mapserv.fclocagi
sudo ln -s /usr/lib/cgi-bin/wms_metadata.xml /usr/lib/cgi-bin/$projectname/wms_metadata.xml

sudo /etc/init.d/apache2 restart


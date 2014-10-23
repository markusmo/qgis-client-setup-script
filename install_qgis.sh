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

apache_conf = "<VirtualHost *:80>\
  ServerAdmin webmaster@localhost\
  ServerName localhost\
\
  DocumentRoot /home/user/QGIS-Web-Client/site\
  <Directory /home/user/QGIS-Web-Client>\
    Options FollowSymLinks\
    AllowOverride None\
    Order allow,deny\
    Allow from all\
    Require all granted\
  </Directory>\
  <Directory /home/user/QGIS-Web-Client/site>\
    Options Indexes FollowSymLinks MultiViews\
    AllowOverride None\
    Order allow,deny\
    Allow from all\
    Require all granted\
  </Directory>\
\
  ScriptAlias /cgi-bin/ /home/user/QGIS-Web-Client/cgi-bin/\
  <Directory \"/home/user/QGIS-Web-Client/cgi-bin/\">\
    AllowOverride None\
    Options +ExecCGI -MultiViews +SymLinksIfOwnerMatch +FollowSymLinks\
    Order allow,deny\
    Allow from all\
    Require all granted\
    AddHandler fcgid-script .fcgi\
    #Uncomment the next line to enable logging to a file\
    #SetEnv QGIS_LOG_FILE /tmp/qgislog.txt\
  </Directory>\
\
  # optional rewrite rules\
\
  # Forbid direct access\
#  RewriteRule ^/cgi-bin/.*$ - [F]\
\
  # Search with SearchPanel\
\
  # sample search on layer 'Hello'\
  #RewriteCond %{QUERY_STRING} ^(?:.*)query=samplesearch&*(?:.*)$\
  #RewriteCond %{QUERY_STRING} ^(?:(?:.*)&)?colour=([^&]*)(?:.*)$\
  #RewriteRule ^/wms/(.+)$ /cgi-bin/qgis_mapserv.fcgi?map=/<path-to-qgis-server-projects>/$1.qgs&SERVICE=WMS&VERSION=1.1.1&REQUEST=GetFeatureInfo&LAYERS=Hello&QUERY_LAYERS=Hello&FEATURE_COUNT=20&INFO_FORMAT=text/xml&SRS=EPSG:4326&FILTER=Hello:\"colour\"\ =\ '%1' [PT]\
\
  # Rewrite /wms/mapname to qgis_mapserv.fcgi?map=/<path-to-qgis-server-projects>/mapname.qgs\
  #RewriteRule ^/wms/(.+)$ /cgi-bin/qgis_mapserv.fcgi?map=/<path-to-qgis-server-projects>/$1.qgs [QSA,PT]\
  # Rewrite /maps/mapname to qgis-web-client main page. mapname will be extracted for wms calls in Javascript code.\
  #RewriteRule ^/maps/([^\.]+)$ /qgis-web-client/site/qgiswebclient.html [PT]\
  # Rewrite /maps/* to qgis-web-client/site (e.g. /maps/gis_icons/mActionZoomNext.png -> /qgis-web-client/site/gis_icons/mActionZoomNext.png)\
  #RewriteRule ^/maps/(.*) /qgis-web-client/site/$1 [PT]\
\
\
  ErrorLog ${APACHE_LOG_DIR}/qgis-web-client-error.log\
  CustomLog ${APACHE_LOG_DIR}/qgis-web-client-access.log combined\
\
</VirtualHost>"

#create a apache-conf for qgis client
touch QGIS-Web-Client/apache-conf/qgis-web-client.conf
echo $apache_conf > QGIS-Web-Client/apache-conf/qgis-web-client.conf
sudo ln -s QGIS-Web-Client/apache-conf/001-qgis-web-client.conf /etc/apache2/sites-available/qgis-web-client.conf
#sudo mv /etc/apache2/sites-enabled/000-default.conf /etc/apache2/sites-enabled/000-default.conf.old

sudo a2enmod rewrite && sudo a2ensite /etc/apache2/sites-available/qgis-web-client.conf && sudo service /etc/init.d/apache2 restart

#create a new project
echo "Name your new QGIS project: "
read projectname
sudo mkdir /usr/lib/cgi-bin/$projectname

sudo ln -s /usr/lib/cgi-bin/qgis_mapserv.fclocagi /usr/lib/cgi-bin/$projectname/qgis_mapserv.fclocagi
sudo ln -s /usr/lib/cgi-bin/wms_metadata.xml /usr/lib/cgi-bin/$projectname/wms_metadata.xml

sudo /etc/init.d/apache2 restart


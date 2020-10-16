#!/bin/bash

if [ -z "$1" ]
    then
        echo "enter the webroot of your website ..."
        read WEB_ROOT
        echo "enter the domain name of your website ..."
        read INSTALL_DOMAIN
    else
    WEB_ROOT=${1}
    INSTALL_DOMAIN=${2}
fi

#apache2 add virtual host
touch /etc/apache2/sites-available/${INSTALL_DOMAIN}

printf "
<VirtualHost *:80>
    ServerAdmin admin@example.com
    ServerName ${INSTALL_DOMAIN}
    ServerAlias www.${INSTALL_DOMAIN}
    DocumentRoot ${WEB_ROOT}
    ErrorLog /var/log/apache2/error.log
    CustomLog /var/log/apache2/access.log combined
</VirtualHost>
" >> /etc/apache2/sites-available/${INSTALL_DOMAIN}.conf

a2ensite ${INSTALL_DOMAIN}.conf
systemctl restart apache2

#SELF DELETE AND EXIT
rm -- "$0"
exit
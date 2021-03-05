#!/bin/bash

if [ -z "$1" ]
    then
        echo "enter the webroot of your website ..."
        read INSTALL_PATH
        echo "enter the domain name of your website ..."
        read DOMAIN_NAME
    else
    INSTALL_PATH=${1}
    DOMAIN_NAME=${2}
fi

INSTALL_PATH=$(realpath -s --canonicalize-missing $INSTALL_PATH)

#apache2 add virtual host
touch /etc/apache2/sites-available/${DOMAIN_NAME}.conf

printf "
<VirtualHost *:80>
    ServerAdmin admin@example.com
    ServerName ${DOMAIN_NAME}
    ServerAlias www.${DOMAIN_NAME}
    DocumentRoot ${INSTALL_PATH}
    ErrorLog /var/log/apache2/error.log
    CustomLog /var/log/apache2/access.log combined
</VirtualHost>
" >> /etc/apache2/sites-available/${DOMAIN_NAME}.conf

a2ensite ${INSTALL_DOMAIN}.conf
a2dissite 000-default.conf
systemctl restart apache2

#SELF DELETE AND EXIT
rm -- "$0"
exit
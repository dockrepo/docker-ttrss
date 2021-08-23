#!/bin/sh

# custom env
echo "TTRSS_SMTP_SERVER=$TTRSS_SMTP_SERVER"
if [ $TTRSS_SMTP_SERVER ];then
	# echo "putenv('TTRSS_SMTP_SERVER=${TTRSS_SMTP_SERVER}');" >> ./config.php
    echo "
        putenv('TTRSS_SMTP_SERVER=${TTRSS_SMTP_SERVER}');
        putenv('TTRSS_SMTP_LOGIN=${TTRSS_SMTP_LOGIN}');
        putenv('TTRSS_SMTP_PASSWORD=${TTRSS_SMTP_PASSWORD}');
        putenv('TTRSS_SMTP_SECURE=${TTRSS_SMTP_SECURE}');

        putenv('TTRSS_SMTP_FROM_ADDRESS=${TTRSS_SMTP_FROM_ADDRESS}');
        putenv('TTRSS_SMTP_FROM_NAME=${TTRSS_SMTP_FROM_NAME}');

    " >> /var/www/config.php
fi

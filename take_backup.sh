#!/bin/bash

# Author : Utkarsh Patel
# This Script reset wordpress site to default state.
# Before setting this script cron you need to add git and should have db dump. 



# Initialize variables
SITE_WEBROOT='/var/www/test.com'
SITE_DB_NAME=$(grep DB_NAME ${SITE_WEBROOT}/wp-config.php | cut -d "'" -f 4)
SITE_DB_USER=$(grep DB_USER ${SITE_WEBROOT}/wp-config.php | cut -d "'" -f 4)
SITE_DB_PASS=$(grep DB_PASS ${SITE_WEBROOT}/wp-config.php | cut -d "'" -f 4)
SITE_DB_BACKUP_PATH="${SITE_WEBROOT}/reset-backup/${SITE_DB_NAME}.sql"
GIT_DIR="${SITE_WEBROOT}/htdocs/wp-content/uploads"
LOG_PATH='/var/log/resetcron.log'


throw_error() {
	echo $1 | tee -ai $LOG_PATH
	exit $2;
}


# Initialize 
if [ ! -d ${GIT_DIR}.git ]; then
    cd ${GIT_DIR};
    git init && git add . && git commit -m "freeze commit" || throw_error "failed to initialize reset env" $?
fi


# Take database backup
if [ ! -f ${SITE_DB_BACKUP_PATH} ]; then 
    if [ ! -d "${SITE_WEBROOT}/reset-backup/" ]; then
        mkdir -p "${SITE_WEBROOT}/reset-backup/"
    fi
    mysqldump -u ${SITE_DB_USER} -p${SITE_DB_PASS} ${SITE_DB_NAME} > ${SITE_DB_BACKUP_PATH} || throw_error "failed to take database backup" $?
fi


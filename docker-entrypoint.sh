#!/bin/bash

# Set consumption directory
mkdir -p ${PAPERLESS_CONSUMPTION_DIR}

# set FTP user password from secret
if [ ! -z ${PAPERLESS_FTP_PWD_FILE} -a -f ${PAPERLESS_FTP_PWD_FILE} ]; then
    PAPERLESS_FTP_PWD=`cat $PAPERLESS_FTP_PWD_FILE`;
fi

# create FTP user
useradd -d ${PAPERLESS_CONSUMPTION_DIR} -p `openssl passwd -1 ${PAPERLESS_FTP_PWD}` ${PAPERLESS_FTP_USER}

chown ${PAPERLESS_FTP_USER} ${PAPERLESS_CONSUMPTION_DIR}
chmod 777 ${PAPERLESS_CONSUMPTION_DIR}

# https://bugs.launchpad.net/ubuntu/+source/openssh/+bug/45234
mkdir -p /var/run/sshd

exec "$@"

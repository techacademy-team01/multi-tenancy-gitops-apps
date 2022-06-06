#!/bin/sh
# Before running the script you need to set two environment variables called "MAILTRAP_USER" and "MAILTRAP_PWD" with your maintrap info, using these command: 
# "export MAILTRAP_USER=my-mailtrap-user"
# "export MAILTRAP_PWD=my-mailtrap-pwd"
echo "Building SetDBParms Configuration for eMail Server"
###################
# INPUT VARIABLES #
###################
CONFIG_NAME="ace-email-server-secid"
CONFIG_TYPE="setdbparms"
CONFIG_NS="tools"
CONFIG_DESCRIPTION="Credentials to connect to eMail Server MailTrap"
##########################
# PREPARE CONFIG CONTENT #
##########################
cat <<EOF >ace-setdbparms-data-email.txt
smtp::mailtrapsecid $MAILTRAP_USER $MAILTRAP_PWD
EOF
CONFIG_DATA_BASE64=$(base64 ace-setdbparms-data-email.txt)
rm ace-setdbparms-data-email.txt
########################
# CREATE CONFIGURATION #
########################
( echo "cat <<EOF" ; cat template-ace-config-data.yaml_template ;) | \
CONFIG_NAME=${CONFIG_NAME} \
CONFIG_TYPE=${CONFIG_TYPE} \
CONFIG_NS=${CONFIG_NS} \
CONFIG_DESCRIPTION=${CONFIG_DESCRIPTION} \
CONFIG_DATA_BASE64=${CONFIG_DATA_BASE64} \
sh > ace-config-setdbparms-email.yaml

echo "SetDBParms Configuration for eMail Server has been created."
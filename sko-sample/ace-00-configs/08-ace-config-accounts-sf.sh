#!/bin/sh
# Before running the script you need to set up the following environment variables related to your SF account:
# "SF_USER", "SF_PWD", "SF_CLIENT_ID", "SF_CLIENT_SECRET", "SF_LOGIN_URL" using these commands: 
# "export SF_ACCOUNT_NAME=sf-account-name-used-in-designer"
# "export SF_USER=my-sf-user-id"
# "export SF_PWD=my-sf-password"
# "export SF_CLIENT_ID=my-sf-client-id"
# "export SF_CLIENT_SECRET=my-sf-client-secret"
# "export SF_LOGIN_URL=my-sf-login-url"
echo "Building Account Configuration for SalesForce"
###################
# INPUT VARIABLES #
###################
CONFIG_NAME="ace-sf-designer-account"
CONFIG_TYPE="accounts"
CONFIG_NS="tools"
CONFIG_DESCRIPTION="Credentials to connect to SF from Designer Flow"
ACCOUNT_NAME="JGRSFAcct"
##########################
# PREPARE CONFIG CONTENT #
##########################
( echo "cat <<EOF" ; cat template-ace-config-account-sf.yaml_template ;) | \
ACCOUNT_NAME=${ACCOUNT_NAME} \
SF_USER=${SF_USER} \
SF_PWD=${SF_PWD} \
SF_CLIENT_ID=${SF_CLIENT_ID} \
SF_CLIENT_SECRET=${SF_CLIENT_SECRET} \
SF_LOGIN_URL=${SF_LOGIN_URL} \
sh > ace-config-account-sf.yaml
CONFIG_DATA_BASE64=$(base64 ace-config-account-sf.yaml)
echo "Cleaning up temp files..."
rm -f ace-config-account-sf.yaml
########################
# CREATE CONFIGURATION #
########################
( echo "cat <<EOF" ; cat template-ace-config-data.yaml_template ;) | \
CONFIG_NAME=${CONFIG_NAME} \
CONFIG_TYPE=${CONFIG_TYPE} \
CONFIG_NS=${CONFIG_NS} \
CONFIG_DESCRIPTION=${CONFIG_DESCRIPTION} \
CONFIG_DATA_BASE64=${CONFIG_DATA_BASE64} \
sh > ace-config-accounts-designer.yaml
echo "Account Configuration for SalesForce has been created."
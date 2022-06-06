#!/bin/sh
echo "Building eMail Server Policy Configuration"
###################
# INPUT VARIABLES #
###################
CONFIG_NAME="ace-email-server-policy"
CONFIG_TYPE="policyproject"
CONFIG_NS="tools"
CONFIG_DESCRIPTION="Policy to configure default values for CP4I Demo"
##########################
# PREPARE CONFIG CONTENT #
##########################
CONFIG_CONTENT_BASE64=$(base64 CP4IEMAIL.zip)
( echo "cat <<EOF" ; cat template-ace-config-content.yaml_template ;) | \
CONFIG_NAME=${CONFIG_NAME} \
CONFIG_TYPE=${CONFIG_TYPE} \
CONFIG_NS=${CONFIG_NS} \
CONFIG_DESCRIPTION=${CONFIG_DESCRIPTION} \
CONFIG_CONTENT_BASE64=${CONFIG_CONTENT_BASE64} \
sh > ace-config-policy-email.yaml

echo "eMail Server Policy Configuration has been created."
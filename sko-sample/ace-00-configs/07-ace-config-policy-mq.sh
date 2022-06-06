#!/bin/sh
echo "Building MQ Policy Configuration"
###################
# INPUT VARIABLES #
###################
CONFIG_NAME="ace-qmgr-demo-policy"
CONFIG_TYPE="policyproject"
CONFIG_NS="tools"
CONFIG_DESCRIPTION="Policy to connect to Demo Queue Manager"
##########################
# PREPARE CONFIG CONTENT #
##########################
CONFIG_CONTENT_BASE64=$(base64 CP4iQMGRDEMO.zip)
( echo "cat <<EOF" ; cat template-ace-config-content.yaml_template ;) | \
CONFIG_NAME=${CONFIG_NAME} \
CONFIG_TYPE=${CONFIG_TYPE} \
CONFIG_NS=${CONFIG_NS} \
CONFIG_DESCRIPTION=${CONFIG_DESCRIPTION} \
CONFIG_CONTENT_BASE64=${CONFIG_CONTENT_BASE64} \
sh > ace-config-policy-mq.yaml

echo "MQ Policy Configuration has been created."
#!/bin/sh
echo "Building User Defined Policy Configuration"
###################
# INPUT VARIABLES #
###################
CONFIG_NAME="ace-cp4i-demo-policy"
CONFIG_TYPE="policyproject"
CONFIG_NS="tools"
CONFIG_DESCRIPTION="Policy to configure default values for CP4I Demo"
##########################
# PREPARE CONFIG CONTENT #
##########################
echo "Packaging Policy..."
CONFIG_CONTENT_BASE64=$(base64 CP4IDEMO.zip)
( echo "cat <<EOF" ; cat template-ace-config-content.yaml_template ;) | \
CONFIG_NAME=${CONFIG_NAME} \
CONFIG_TYPE=${CONFIG_TYPE} \
CONFIG_NS=${CONFIG_NS} \
CONFIG_DESCRIPTION=${CONFIG_DESCRIPTION} \
CONFIG_CONTENT_BASE64=${CONFIG_CONTENT_BASE64} \
sh > ace-config-policy-udp.yaml
########################
# CREATE CONFIGURATION #
########################
echo "User Defined Policy Configuration has been created."
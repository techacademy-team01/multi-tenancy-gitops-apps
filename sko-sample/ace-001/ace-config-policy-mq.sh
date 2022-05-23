#!/bin/sh
echo "Building MQ Policy Configuration"
###################
# INPUT VARIABLES #
###################
NS="tools"
POLICY_NAME="ace-mq-policy"
##########################
# PREPARE CONFIG CONTENT #
##########################
echo "Packaging Policy..."
POLICY_BASE64_CONTENT=$(base64 CP4iQMGRDEMO.zip)
( echo "cat <<EOF" ; cat template-ace-config-policy.yaml_template ;) | \
NS=${NS} \
POLICY_NAME=${POLICY_NAME} \
POLICY_BASE64_CONTENT=${POLICY_BASE64_CONTENT} \
sh > ace-config-policy-mq.yaml
########################
# CREATE CONFIGURATION #
########################
echo "MQ Policy Configuration has been created."

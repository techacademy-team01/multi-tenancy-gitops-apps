#!/bin/sh
echo "Building BAR Auth Configuration"
###################
# INPUT VARIABLES #
###################
NS="tools"
POLICY_NAME="github-barauth"
BARAUTH_DATA=$(base64 template-ace-barauth-data.json)
########################
# CREATE CONFIGURATION #
########################
( echo "cat <<EOF" ; cat template-ace-config-barauth.yaml ;) | \
NS=${NS} \
POLICY_NAME=${POLICY_NAME} \
BARAUTH_DATA=${BARAUTH_DATA} \
sh > ace-config-barauth.yaml
echo "BAR Auth Configuration has been created."

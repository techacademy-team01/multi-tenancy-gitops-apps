#!/bin/sh
echo "Building TrustStore Configuration"
###################
# INPUT VARIABLES #
###################
ES_INST_NAME='es-demo'
ES_NAMESPACE='tools'
CONFIG_NAME="es-cert.jks"
CONFIG_TYPE="truststore"
CONFIG_DESCRIPTION="JKS certificate for Event Streams instance es-demo"
CONFIG_NS="tools"
########################
# CREATE CONFIGURATION #
########################
oc extract secret/${ES_INST_NAME}-cluster-ca-cert -n ${ES_NAMESPACE} --keys=ca.password
TRUSTSTORE_PWD=`cat ca.password`
oc extract secret/${ES_INST_NAME}-cluster-ca-cert -n ${ES_NAMESPACE} --keys=ca.p12
keytool -importkeystore -srckeystore ca.p12 -srcstoretype PKCS12 -destkeystore es-cert.jks  -deststoretype JKS -srcstorepass ${TRUSTSTORE_PWD} -deststorepass ${TRUSTSTORE_PWD} -srcalias ca.crt -destalias ca.crt -noprompt
CONFIG_DATA_BASE64=$(base64 es-cert.jks)
echo "Cleaning up temp files..."
rm -f ca.password
rm -f ca.p12
rm -f es-cert.jks
( echo "cat <<EOF" ; cat template-ace-config-data.yaml_template ;) | \
CONFIG_NAME=${CONFIG_NAME} \
CONFIG_TYPE=${CONFIG_TYPE} \
CONFIG_NS=${CONFIG_NS} \
CONFIG_DESCRIPTION=${CONFIG_DESCRIPTION} \
CONFIG_DATA_BASE64=${CONFIG_DATA_BASE64} \
sh > ace-config-truststore.yaml

echo "TrustStore Configuration has been created."
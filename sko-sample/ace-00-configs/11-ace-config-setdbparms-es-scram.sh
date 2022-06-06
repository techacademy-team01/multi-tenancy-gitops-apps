#!/bin/sh
echo "Building SetDBParms Configuration for ES"
###################
# INPUT VARIABLES #
###################
ES_INST_NAME='es-demo'
ES_NAMESPACE='tools'
ES_USER_ID='ace-user'
CONFIG_NAME="ace-es-demo-scram-secid"
CONFIG_TYPE="setdbparms"
CONFIG_NS="tools"
CONFIG_DESCRIPTION="Credentials to connect using SCRAM to ES Demo Cluster"
##########################
# PREPARE CONFIG CONTENT #
##########################
oc extract secret/${ES_INST_NAME}-cluster-ca-cert -n ${ES_NAMESPACE} --keys=ca.password
TRUSTSTORE_PWD=`cat ca.password`
oc extract secret/${ES_USER_ID} -n ${ES_NAMESPACE} --keys=password
ES_USER_PWD=`cat password`
cat <<EOF >ace-setdbparms-data-es-scram.txt
truststore::truststorePass dummy $TRUSTSTORE_PWD
kafka::esdemoSecId $ES_USER_ID $ES_USER_PWD
EOF
CONFIG_DATA_BASE64=$(base64 ace-setdbparms-data-es-scram.txt)
echo "Cleaning up temp files..."
rm -f ca.password
rm -f password
rm -f ace-setdbparms-data-es-scram.txt

########################
# CREATE CONFIGURATION #
########################
( echo "cat <<EOF" ; cat template-ace-config-data.yaml_template ;) | \
CONFIG_NAME=${CONFIG_NAME} \
CONFIG_TYPE=${CONFIG_TYPE} \
CONFIG_NS=${CONFIG_NS} \
CONFIG_DESCRIPTION=${CONFIG_DESCRIPTION} \
CONFIG_DATA_BASE64=${CONFIG_DATA_BASE64} \
sh > ace-config-setdbparms-es-scram.yaml
echo "SetDBParms Configuration for ES has been created."
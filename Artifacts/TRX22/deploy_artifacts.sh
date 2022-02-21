#!/bin/bash

if [ $# -ne 3 ]
then
        echo "deploy_artifacts.sh called with incorrect number of arguments."
        echo "deploy_artifacts.sh <DeployBaseDir> <DeployDir> <customer_artifacts_dir>"
        echo "For example; deploy_artifacts.sh /plm/pnnas/ppic/users/<deploy_dir> /plm/pnnas/ppic/users/<deploy_dir>/TranslatorWorker <Artifacts/TRX22>"
        exit 1
fi

echo "Executing deploy_artifacts.sh..."

DEPLOY_BASE_DIR=$1
DEPLOY_DIR=$2
CUSTOMER_ARTIFACTS_DIR=$3


CONFIG_FILE=${DEPLOY_DIR}/pvtrans/tessUG.config
chmod 0755 ${CONFIG_FILE} || { exit 1;}

cp -f ${CUSTOMER_ARTIFACTS_DIR}/run_ugtopv ${DEPLOY_DIR}/run_ugtopv || { exit 1;}
cp -f ${CUSTOMER_ARTIFACTS_DIR}/tessUG.config ${CONFIG_FILE} || { exit 1;}
cp -f ${CUSTOMER_ARTIFACTS_DIR}/NXJT_Translator_README.txt ${DEPLOY_BASE_DIR}/ || { exit 1;}

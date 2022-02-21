#!/bin/bash

if [ $# -ne 3 ]
then
        echo "deployTranslatorWorkerUnit.sh called with incorrect number of arguments."
        echo "deployTranslatorWorkerUnit.sh <UnitPath> <DeployDir> <Customer>"
        echo "For example; deployTranslatorWorkerUnit.sh /plm/pnnas/ppic/users/<unit_name> /plm/pnnas/ppic/users/<deploy_dir> <TRX22>"
        exit 1
fi

UNIT_PATH=$1
DEPLOY_BASE_DIR=$2
CUSTOMER_ID=$3

DEPLOY_DIR=${DEPLOY_BASE_DIR}/TranslatorBinaries/
SOURCE_PATH=${UNIT_PATH}/lnx64/Products/TranslatorWorker

if [ ! -d ${DEPLOY_DIR} ]
then
	echo "Creating deployment directory ${DEPLOY_DIR}"
	mkdir -p ${DEPLOY_DIR} || { exit 1;}
	chmod -R 0777 ${DEPLOY_DIR} || { exit 1;}
fi

# Copy all 
cp -r ${SOURCE_PATH}/*   ${DEPLOY_DIR}/ || { exit 1;}

# Then remove selected iteams
rm -rf ${DEPLOY_DIR}/debug || { exit 1;}
rm -rf ${DEPLOY_DIR}/license || { exit 1;}
rm -rf ${DEPLOY_DIR}/dockerfile || { exit 1;}

# Run customer specific deploy script to copy artifacts
chmod 0777 ${CUSTOMER_ID}/deploy_artifacts.sh || { exit 1;}
${CUSTOMER_ID}/deploy_artifacts.sh ${DEPLOY_BASE_DIR} ${DEPLOY_DIR} ${CUSTOMER_ID} || { exit 1;}




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
RUN_FILE=${SOURCE_PATH}/pvtrans/run_ugtopv
CONFIG_FILE=${DEPLOY_DIR}/pvtrans/tessUG.config

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

cp  ${RUN_FILE}            ${DEPLOY_DIR}/ || { exit 1;}
#cp  ${CONFIG_FILE}         ${DEPLOY_BASE_DIR}/

DEPLOYED_CONFIG_FILE=${CONFIG_FILE}
chmod 0755 ${DEPLOYED_CONFIG_FILE} || { exit 1;}

#sed -i 's/UGII_PV_TRANS_MODEL_ANN=1//g' ${DEPLOY_DIR}/run_ugtopv
#sed -i 's/export UGII_PV_TRANS_MODEL_ANN//g' ${DEPLOY_DIR}/run_ugtopv
#sed -i 's/exec ${APPNAME} "${@}"/exec ${APPNAME} "${@}" -enable_hybrid_saas -single_part/g' ${DEPLOY_DIR}/run_ugtopv

#sed -i 's/structureOption =.*/structureOption = "MIMIC"/g' ${DEPLOYED_CONFIG_FILE}
#sed -i 's/pmiOption =.*/pmiOption = "THIS_LEVEL_ONLY"/g' ${DEPLOYED_CONFIG_FILE}
#sed -i 's/includeBrep =.*/includeBrep = false/g' ${DEPLOYED_CONFIG_FILE}
#sed -i 's/autoNameSanitize =.*/autoNameSanitize = false/g' ${DEPLOYED_CONFIG_FILE}
#sed -i 's/autoLowLODgeneration =.*/autoLowLODgeneration = false/g' ${DEPLOYED_CONFIG_FILE}
#sed -i 's/numLODs =.*/numLODs = 1/g' ${DEPLOYED_CONFIG_FILE}
#sed -i 's/AdvCompressionLevel =.*/AdvCompressionLevel = 0.01/g' ${DEPLOYED_CONFIG_FILE}

#sed -i 's/numLODs =.*/numLODs = 1/g' ${DEPLOYED_CONFIG_FILE}
#sed -i 's/getNXBodyNames =.*/getNXBodyNames = true/g' ${DEPLOYED_CONFIG_FILE}
#sed -i 's/getCADProperties =.*/getCADProperties = "NONE"/g' ${DEPLOYED_CONFIG_FILE}

#sed -i '/LOD "2" /{:b;$!N;/}$/!bb;s/{.*}//}'  ${DEPLOYED_CONFIG_FILE}
#sed -i '/LOD "3" /{:b;$!N;/}$/!bb;s/{.*}//}'  ${DEPLOYED_CONFIG_FILE}

#sed -i 's/LOD "2".*//g' ${DEPLOYED_CONFIG_FILE}
#sed -i 's/LOD "3".*//g' ${DEPLOYED_CONFIG_FILE}

cp -f ${CUSTOMER_ID}/run_ugtopv ${DEPLOY_DIR}/run_ugtopv || { exit 1;}
cp -f ${CUSTOMER_ID}/tessUG.config ${DEPLOYED_CONFIG_FILE} || { exit 1;}
cp -f ${CUSTOMER_ID}/NXJT_Translator_README.txt ${DEPLOY_BASE_DIR}/ || { exit 1;}


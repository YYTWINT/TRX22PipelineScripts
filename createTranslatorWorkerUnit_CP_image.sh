#!/bin/bash

if [ $# -ne 3 ] 
then
	echo "createTranslatorWorkerUnit_CP_image.sh called with incorrect number of arguments."
	echo "createTranslatorWorkerUnit_CP_image.sh <NXVersion> <UnitPath> <CPNumber>"
	echo "For example; createTranslatorWorkerUnit_CP_image.sh nx2206.latest /plm/pnnas/ppic/users/<unit_name> NX#XXXXX"
	exit 1
fi

NX_RELEASE=$1
UNIT_PATH=$2
CP_NUMBER=$3

/usr/site/devop_tools/bin/unit add -b -p @${NX_RELEASE} -t DEV -w SUB ${UNIT_PATH} -R y -O y -DO_LINK_OPT y
initFile=${UNIT_PATH}/init.def
sed -i 's/DO_TARI_RECOMPILES.*/DO_TARI_RECOMPILES       1/g' $initFile
sed -i 's/DO_SOURCE_RECOMPILES.*/DO_SOURCE_RECOMPILES       1/g' $initFile
sed -i 's/DO_LINK_OPT.*/DO_LINK_OPT       1/g' $initFile
sed -i 's/DO_DEBUG.*/DO_DEBUG       0/g' $initFile

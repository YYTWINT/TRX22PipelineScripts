#!/bin/bash

if [ $# -ne 2 ] 
then
	echo "buildTranslatorWorkerUnit_CP_image.sh called with incorrect number of arguments."
	echo "buildTranslatorWorkerUnit_CP_image.sh <UnitPath> <CPNumber>"
	echo "For example; buildTranslatorWorkerUnit_CP_image.sh /plm/pnnas/ppic/users/<unit_name> NX#XXXXX"
	exit 1
fi

UNIT_PATH=$1
CP_NUMBER=$2

/usr/site/devop_tools/bin/unit run ${UNIT_PATH} /usr/site/devop_tools/bin/dt cli set -C -A ${CP_NUMBER}
/usr/site/devop_tools/bin/unit run ${UNIT_PATH} b 
/usr/site/devop_tools/bin/unit run ${UNIT_PATH} b image ugtopv
/usr/site/devop_tools/bin/unit run ${UNIT_PATH} b product TranslatorWorker
/usr/site/devop_tools/bin/unit run ${UNIT_PATH} b product validate_worker TranslatorWorker
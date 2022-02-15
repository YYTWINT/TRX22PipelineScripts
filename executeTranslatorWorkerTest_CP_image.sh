#!/bin/bash

if [ $# -lt 1 ] 
then
	echo "executeTranslatorWorkerTest_CP_image.sh called with incorrect number of arguments."
	echo "executeTranslatorWorkerTest_CP_image.sh <UnitPath>"
	echo "For example; executeTranslatorWorkerTest_CP_image.sh /plm/pnnas/ppic/users/<unit_name>"
	exit 1
fi

UNIT_PATH=$1
export SPLM_LICENSE_SERVER=28000@pnlv6002,28000@inpnsweb01 
/usr/site/devop_tools/bin/unit run ${UNIT_PATH} devtest runtest NXTranslators.rep:TranslatorWorker.set -p 6
casesFailed=`grep "Number of tests:" ${UNIT_PATH}/dt/runs/devtestLastRunFails.txt | cut -d ":" -f2 | tr -d " "`
if [ $casesFailed != 0 ]
then
	/usr/site/devop_tools/bin/unit run ${UNIT_PATH} devtest runfails -p 6 -keep -local
else
	echo "No test case failed. So skipping re-run of devtest."
fi

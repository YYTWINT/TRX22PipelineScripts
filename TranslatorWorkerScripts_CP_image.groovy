def createUnitCPImage()
{
	echo "Creating unit..."
	script{		
		def unitFullPath="${params.UnitPath}/${params.NXRelease}_TranslatorWorker_${BUILD_TIMESTAMP}"
		sh "chmod +x ./createTranslatorWorkerUnit_CP_image.sh "
		sh "./createTranslatorWorkerUnit_CP_image.sh ${params.NXRelease} ${unitFullPath} ${params.CPNumber}"		
	}
}

def buildUnitCPImage()
{
	echo "Building unit..."
	script{		
		def unitFullPath="${params.UnitPath}/${params.NXRelease}_TranslatorWorker_${BUILD_TIMESTAMP}"
		sh "chmod +x ./buildTranslatorWorkerUnit_CP_image.sh "
		sh "./buildTranslatorWorkerUnit_CP_image.sh ${unitFullPath} ${params.CPNumber}"		
	}
}

def TestUnitCPImage()
{
	echo "Executing devtests..."
	script{		
		def unitFullPath="${params.UnitPath}/${params.NXRelease}_TranslatorWorker_${BUILD_TIMESTAMP}"
		sh "chmod +x ./executeTranslatorWorkerTest_CP_image.sh "
		sh "./executeTranslatorWorkerTest_CP_image.sh ${unitFullPath}"		
	}
}

return this

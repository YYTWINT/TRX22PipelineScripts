def sendSuccessEmail()
{
	def subject = "Job Executed '${env.JOB_NAME} - [${env.BUILD_NUMBER}] - ${currentBuild.currentResult}'"
	def details = """<p>Job - '${env.JOB_NAME}' </p>
				 <p>Build number - '[${env.BUILD_NUMBER}]'</p>
				 <p>Status - '${currentBuild.currentResult}' </p>
				 
				 <p>Check console output at &QUOT;<a href='${env.BUILD_URL}'>${env.JOB_NAME} [${env.BUILD_NUMBER}]</a>&QUOT;</p>"""
	emailext(
		subject: subject,
		body: details,
		to: 'yytwint.sisw@siemens.com,nilesh.lakhotia@siemens.com,dattaprasad.sonawadekar@siemens.com, rakesh.thakur@siemens.com'
	)
}
return this


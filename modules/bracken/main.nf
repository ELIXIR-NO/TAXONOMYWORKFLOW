process bracken {
	debug params.debug
	label 'bracken'
	conda './modules/bracken/environments/bracken_2.9.yaml'
	cpus params.defaultcpus
	memory params.defaultmemory
	time params.defaulttime
	maxForks params.defaultmaxForks
	maxErrors params.maxErrors
	errorStrategy params.errorStrategy		
	maxRetries params.maxRetries
	input:
		path(brackenIN)
	output:
		path "*_bracken.tsv", emit: bracken_OUT
	when:
		true
	
	script:	
		egressPath = params.egresspath
		kraken2_refdata = params.launchdir + "/resources/kraken2/"
		brackenOUT = brackenIN.getName().substring(0, brackenIN.getName().lastIndexOf('_kraken2Report.txt')) + "_bracken.tsv"
		brackenREPORT = brackenIN.getName().substring(0, brackenIN.getName().lastIndexOf('_kraken2Report.txt')) + "_brackenReport.txt"			
		template 'bracken.sh'
}
process egress_TAXONOMYPIPELINE {
	debug params.debug
	label 'egress_TAXONOMYPIPELINE'	
	cpus params.defaultcpus
	memory params.defaultmemory
	time params.defaulttime
	maxForks params.defaultmaxForks
	maxErrors params.maxErrors
	errorStrategy params.errorStrategy		
	maxRetries params.maxRetries
	input:
		path(egressIN) //the bracken.tsv
	output:		
		path "*_bracken.tsv", includeInputs:true, emit: egress_TAXONOMY_OUT
	when:
		true
	script:			
		egressPath = params.egresspath
		egressOUT = egressIN
		template 'egress_TAXONOMYPIPELINE.sh'
}
process ingress_TAXONOMYPIPELINE {	
	debug params.debug
	label 'ingress_TAXONOMYPIPELINE'
	cpus params.defaultcpus
	memory params.defaultmemory
	time params.defaulttime
	maxForks params.defaultmaxForks
	maxErrors params.maxErrors
	errorStrategy params.errorStrategy		
	maxRetries params.maxRetries		
        input:
		tuple val(ingressNAME), path(ingressFILES)
	output:
		path "*.dedupe.good.tagged.filter.repaired.fastq.gz", includeInputs:true, emit: ingress_TAXONOMYPIPELINE_OUT		
	when:
		true	
	script:		
		egressPath = params.egresspath
		
		ingressIN1 = ingressFILES[0].getName()
		ingressIN2 = ingressFILES[1].getName()

		ingressOUT1 = ingressFILES[0].getName()
		ingressOUT2 = ingressFILES[1].getName()

		template 'ingress_TAXONOMYPIPELINE.sh'
}
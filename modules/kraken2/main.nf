process kraken2 {
	debug params.debug
	label 'kraken2'
	conda './modules/kraken2/environments/kraken2_2.1.3.yaml'
	cpus params.defaultcpus
	memory params.defaultmemory
	time params.defaulttime
	maxForks params.defaultmaxForks
	maxErrors params.maxErrors
	errorStrategy params.errorStrategy		
	maxRetries params.maxRetries
	input:
		tuple path(kraken2IN1), path(kraken2IN2)
	output:
		path "*_kraken2Report.txt", emit: kraken2OUT
	when:
		true
	
	script:	
		egressPath = params.egresspath
		kraken2Threads = params.defaultcpus
		kraken2_refdata = params.launchdir + "/resources/kraken2/"
		
		kraken2_report = kraken2IN1.getBaseName().substring(0, kraken2IN1.getBaseName().lastIndexOf('_1')) + "_kraken2Report.txt"
		kraken2OUT = kraken2IN1.getBaseName().substring(0, kraken2IN1.getBaseName().lastIndexOf('_1')) + "_kraken2_minimizer.fastq"

		if (kraken2_report.startsWith("_")) {
			kraken2_report = kraken2IN1.getBaseName().substring(1, kraken2IN1.getBaseName().lastIndexOf('_1')) + "_kraken2Report.txt"
		}

		if (kraken2OUT.startsWith("_")) {
			kraken2OUT = kraken2IN1.getBaseName().substring(1, kraken2IN1.getBaseName().lastIndexOf('_1')) + "_kraken2_minimizer.fastq"
		}

		template 'kraken2.sh'
}
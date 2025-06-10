include {TAXONOMYPIPELINE} from './modules/TAXONOMYPIPELINE'

workflow {
	def ingress_ch = channel
		.fromFilePairs(params.ingresspath + '*_{1,2}.dedupe.good.tagged.filter.repaired.fastq.gz')  
		.toSortedList( { a, b -> a[0] <=> b[0] } )
		.flatMap()
	
	def TAXONOMYWORKFLOW_ch = channel.of(TAXONOMYWORKFLOW(ingress_ch))
	
	TAXONOMYWORKFLOW_ch | view()
}


workflow TAXONOMYWORKFLOW {
	take:
		ingress_ch
	main:
		TAXONOMYPIPELINE(ingress_ch)
	emit:
		TAXONOMYPIPELINE.out
}


workflow.onComplete {
    println ( workflow.success ? """
        TAXONOMYWORKFLOW execution summary
        ---------------------------
        Completed at: ${workflow.complete}
        Duration    : ${workflow.duration}
        Success     : ${workflow.success}
        workDir     : ${workflow.workDir}
        exit status : ${workflow.exitStatus}
        """ : """
        Failed: ${workflow.errorReport}
        exit status : ${workflow.exitStatus}
        """
    )
}
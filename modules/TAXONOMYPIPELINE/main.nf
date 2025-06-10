include {ingress_TAXONOMYPIPELINE} from '../../modules/ingress'
include {kraken2} from '../../modules/kraken2'
include {bracken} from '../../modules/bracken'
include {egress_TAXONOMYPIPELINE} from '../../modules/egress'

workflow {
	def ingress_ch = channel
		.fromFilePairs(params.ingresspath + '*_{1,2}.dedupe.good.tagged.filter.repaired.fastq.gz')  
		.toSortedList( { a, b -> a[0] <=> b[0] } )
		.flatMap()

	def TAXONOMYPIPELINE_ch = channel.of(TAXONOMYPIPELINE(ingress_ch))

	TAXONOMYPIPELINE_ch | view()
}

workflow TAXONOMYPIPELINE {
	take:
		ingress_ch
	main:
		ingress_TAXONOMYPIPELINE(ingress_ch) | kraken2 | bracken | egress_TAXONOMYPIPELINE
	emit:
		egress_TAXONOMYPIPELINE.out
}

workflow.onComplete {
    println ( workflow.success ? """
        TAXONOMYPIPELINE execution summary
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
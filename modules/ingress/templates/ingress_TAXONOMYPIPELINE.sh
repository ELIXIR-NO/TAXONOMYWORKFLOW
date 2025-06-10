#!/bin/bash
#Default pipeline or stage egress for pair read tools
if [ ! -f $ingressOUT1 ]; then
	cp $ingressIN1 $ingressOUT1
fi

if [ ! -f $ingressOUT2 ]; then
	cp $ingressIN2 $ingressOUT2
fi

#Record the files
echo '$ingressIN1 $ingressOUT1' >> $egressPath/TAXONOMYPIPELINE_ingressedFiles.txt
echo '$ingressIN2 $ingressOUT2' >> $egressPath/TAXONOMYPIPELINE_ingressedFiles.txt
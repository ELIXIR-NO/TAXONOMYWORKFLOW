#!/bin/bash
unlink ./INGRESS
unlink ./EGRESS
ln -s $1 ./INGRESS
ln -s $2 ./EGRESS
./scripts/clean.sh
rm ./OUTPUT_TAXONOMYPIPELINE/*
conda run -n nextflow_25.04.2 nextflow -log ./EGRESS/TAXONOMYPIPELINE.log run -profile TAXONOMYPIPELINE_test -w $3 ./modules/TAXONOMYPIPELINE/main.nf
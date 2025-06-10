#!/bin/bash
#Test a complete workflow
unlink ./INGRESS
unlink ./EGRESS
ln -s $1 ./INGRESS
ln -s $2 ./EGRESS
./scripts/clean.sh
rm ./OUTPUT/*
conda run -n nextflow_25.04.2 nextflow -log ./EGRESS/QUALITYWORKFLOW.log run -profile TEST -w $3 main.nf
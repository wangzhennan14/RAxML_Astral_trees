#!/bin/bash
# runs RAxML ML and bootstrap analyses on the .reduced alignment generated by RAxML.
# RAxML must be run and have produced a .reduced alignment prior to running this script.
cd $(dirname $1)
id=$(basename $(dirname $1))
reduced=$(basename $1)

~/standard-RAxML/raxmlHPC-AVX -f a -m GTRGAMMA -N 100 -x 12345 -p 25258 -n ${id}.txt -s $reduced

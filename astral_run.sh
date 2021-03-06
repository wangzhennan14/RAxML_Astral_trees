#!/bin/bash

# Make directories for RAxML trees and bootstrap data
mkdir tree_files boot_trees

# cp gene tree files to single dir from working dir
find . -name "RAxML_bipartitions.*" -exec cp {} tree_files/ \;

# merge all trees into a single file for Astral
cd tree_files
#rename 's/$/\.tre/' RAxML_b*
sed -n wRAx_genetrees_merge.tre *.txt
cd ..

# make file with list of paths to bootstrap files
find . -name "RAxML_bootstrap.*" -exec cp {} boot_trees/ \;
cd boot_trees
for file in ./*
do
    readlink -f "$file" >> bootstrap.filedir.list.txt
done
cd ..

# the option -Xmx100G gives Java 100GB of RAM, make sure this is appropriate for your system. The last item is the name of your final AstralIII tree, edit if you like.
java -Xmx100G -jar ~/ASTRAL/astral.5.5.6.jar -i tree_files/RAx_genetrees_merge.tre -b boot_trees/bootstrap.filedir.list.txt -r 100 -o My_AstralIII_sp_tree.tre

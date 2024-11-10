#!/bin/bash 
name=$1

circlator minimus2 --no_pre_merge "$name".pilon2.14.fasta "$name"_assembly2_no_overhang

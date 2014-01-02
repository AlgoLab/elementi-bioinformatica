###
#
# Solution of lab assignment 6b (http://git.io/elem-bioinf-lab6#14)
# Course: "Elementi di Bioinformatica" (http://algolab.eu/didattica/elementi-di-bioinformatica/)
# Corso di Laurea in Informatica (BSc in Computer Science)
# Univ. degli Studi di Milano-Bicocca, Milan, Italy
# Academic year: 2013/14
#
# Copyright 2013 Yuri Pirola (http://algolab.eu/pirola)
#
# This work is licensed under the Creative Commons Attribution 3.0
# Unported License. To view a copy of this license, visit
# http://creativecommons.org/licenses/by/3.0/
#
###


require 'bio-ensembl-rest'
include EnsemblRest

REGION='1:151050001..151250000:1'

## List all the genes of the region
EnsemblRest.connect_db

genes = Features.feature_region('Homo sapiens',
                                REGION,
                                ['gene'],
                                response: 'ruby')
genes.each do |gene|
  puts [gene['ID'],
        gene['external_name'],
        gene['seq_region_name'],
        gene['start'], gene['end'],
        gene['strand']].join "\t"
end

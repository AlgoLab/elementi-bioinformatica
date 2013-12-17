###
#
# Solution of lab assignment 6a (http://git.io/elem-bioinf-lab6#13)
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


require_relative 'ex-2b-fastareader.rb'

require 'bio-ensembl-rest'
include EnsemblRest

REGION='1:151050001..151250000:1'

## Read the sequence from file
fr = FASTAReader.new('./ex-5.fa')
fasta_seq = fr.find { |s| s.identifier == 'chr1' }

## Read the sequence from Ensembl
EnsemblRest.connect_db
db_seq = Sequence.sequence_region 'Homo sapiens', REGION, response: 'text'

## Compare the sequences
if fasta_seq and db_seq and fasta_seq.sequence == db_seq
  puts 'The two sequences are EQUAL.'
else
  puts 'The two sequences are DIFFERENT.'
end



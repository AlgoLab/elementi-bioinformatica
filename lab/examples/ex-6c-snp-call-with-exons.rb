###
#
# Solution of lab assignment 6c (http://git.io/elem-bioinf-lab6#15)
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


require 'bio-samtools'
require 'bio-ensembl-rest'
include EnsemblRest

BASE_START=151050000
REGION='1:151050001..151250000:1'

puts "Retrieving the exons of region #{REGION}..."

EnsemblRest.connect_db

db_exons = Features.feature_region('Homo sapiens',
                                   REGION,
                                   ['exon'],
                                   response: 'ruby')
exons = {}
db_exons.each do |exon|
  exons[exon['ID']] = [exon['ID'], exon['start']..exon['end']]
end
db_exons = nil
exons = exons.values

puts "Retrieved exons:"
exons.each do |exon|
  puts "#{exon[0]}\t#{exon[1]}"
end

puts "Opening BAM file..."
bam = Bio::DB::Sam.new(:bam => 'ex-5.bam', :fasta => 'ex-5.fa')
bam.open

puts "Putative SNPs:"
n = 0
bam.mpileup do |pileup|
  if pileup.non_ref_count > 0
    n = n+1
    results = [ pileup.ref_name,
                BASE_START+pileup.pos,
                pileup.coverage,
                pileup.ref_base]
    counts = pileup.non_refs
    counts[pileup.ref_base.to_sym] = pileup.ref_count
    counts.each do |base,bcount|
      results << "#{base}:#{bcount}"
    end
    results << '[' + exons.find_all do |exon|
      exon[1] === (BASE_START+pileup.pos)
    end .map {|exon| exon[0]} .join(',') + ']'
    puts results.join("\t")
  end
end

puts "Closing BAM file..."
bam.close

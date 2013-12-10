###
#
# Solution of lab assignment 5a (http://git.io/elem-bioinf-lab5#11)
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


## Execute only if it is called directly (not if 'required' by another file)
if __FILE__==$0

  puts "Opening file..."
  bam = Bio::DB::Sam.new(:bam => 'ex-5.bam', :fasta => 'ex-5.fa')
  bam.open

  puts "Computing average coverage..."
  puts bam.chromosome_coverage("chr1", 108161, 10)

  puts "Computing average coverage..."
  puts bam.average_coverage("chr1", 108050, 100)
  puts bam.average_coverage("chr1", 108161, 100)

  puts "Reads overlapping region chr1:108065-108070..."
  bam.fetch("chr1", 108065, 108070).each do |aln|
    puts aln.qname
  end

  puts "Pileup of region chr1:114915-114925..."
  bam.mpileup({:r => "chr1:114915-114925"}) do |pileup|
    puts pileup
  end

  puts "Closing file..."
  bam.close

end

###
#
# Solution of lab assignment 3b (http://git.io/elem-bioinf-lab3#11)
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


require_relative 'ex-3a-annotgene.rb'

class GTFReader

private

  # Does not allow instances
  def initialize
  end

public

  def GTFReader.read(filename)
    genes = {}
    File.open(filename, 'r').each do |line|
      line.strip!
      fields = line.split "\t"
      # Skip if it is not an exon
      next unless fields[2] == 'exon'
      # Create a new dictionary whose key-value pairs are
      # the pairs of the last column (separated by ;)
      info = Hash[ fields[8]  \
                     .split(';')  \
                     .map { |x| x.split.map { |y| y.delete '"' } } ]
      ['gene_id', 'transcript_id'].each do |key|
        raise RuntimeError, "Key #{key} not present in line: >#{line}<" if not info[key]
      end
      if not genes[info['gene_id']]
        genes[info['gene_id']] = AnnotatedGene.new(info['gene_id'], fields[0], fields[6])
      end
      gene = genes[info['gene_id']]
      if not gene.transcripts[info['transcript_id']]
        trans = gene.add_new_transcript info['transcript_id']
      else
        trans = gene.transcripts[info['transcript_id']]
      end
      trans.exons << (fields[3]..fields[4])
    end
    genes
  end

end



## Execute only if it is called directly (not if 'required' by another file)
if __FILE__==$0

  genes = GTFReader.read('./ex-3.gtf')

  tot_transcripts = genes.each_value.inject(0) {|sum, gene| sum += gene.transcripts.length }
  puts "The file describes #{ genes.length } gene structures with #{ tot_transcripts } transcripts."
  puts "The average number of transcripts per gene is #{ Float(tot_transcripts) / genes.length }."

  single_transcript_genes = genes.values.inject(0) do |sum, gene|
    sum += if gene.transcripts.length==1
             1
           else
             0
           end
  end
  puts "There are #{single_transcript_genes} genes with a single transcript."

  tot_exons = genes.each_value.inject(0) do |sum, gene|
    sum += gene.transcripts.each_value.inject(0) do |sum_exons, transcript|
      sum_exons += transcript.exons.length
    end
  end
  puts "The average number of exons per transcript is #{ Float(tot_exons)/tot_transcripts }."

end

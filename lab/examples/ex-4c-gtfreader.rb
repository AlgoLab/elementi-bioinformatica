###
#
# Solution of lab assignment 4c (http://git.io/elem-bioinf-lab4#6)
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


require_relative 'ex-4a-annotgene.rb'
require_relative 'ex-2b-fastareader.rb'

class GTFReader

private

  # Does not allow instances
  def initialize
  end

  def GTFReader.read_gtf(filename)
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
      trans.exons << ((fields[3].to_i)..(fields[4].to_i))
    end
    genes
  end

  def GTFReader.populate_sequences(genes, filename)
    # Group genes by chromosome
    genes_on_chr = Hash.new { |h,k| h[k]=[] }
    genes.each_value do |gene|
      genes_on_chr[gene.chrom] << gene
    end
    FASTAReader.new(filename).each do |s|
      next unless genes_on_chr.has_key? s.identifier
      genes_on_chr[s.identifier].each do |gene|
        gene.transcripts.each_value do |transcript|
          seq_arr = []
          transcript.exons.sort_by {|x| x.begin }.each do |exon|
            # GTF coordinates are 1-based, while Ruby strings are 0-based
            seq_arr << s.sequence[(exon.begin-1)...exon.end]
          end
          transcript.sequence = seq_arr.join
          transcript.reverse_and_complement! if gene.strand == '-'
        end
      end
    end
  end

public

  def GTFReader.read(gtf_filename, fa_filename=nil)
    genes = GTFReader.read_gtf(gtf_filename)
    if fa_filename
      GTFReader.populate_sequences(genes, fa_filename)
    end
    genes
  end

end



## Execute only if it is called directly (not if 'required' by another file)
if __FILE__==$0

  genes = GTFReader.read('./ex-4-plus-minus.gtf', './ex-4.fa')

  # Print the genes in the GTF format
  genes.each_value do |gene|
    puts gene.to_gtf
  end
  # Print the genes in the FASTA format
  genes.each_value do |gene|
    puts gene.to_fasta(60)
  end

end

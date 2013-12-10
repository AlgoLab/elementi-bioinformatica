###
#
# Solution of lab assignment 3a (http://git.io/elem-bioinf-lab3#10)
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


class AnnotatedTranscript

private

  # Store at class level all the transcript ids.
  @@ids = {}

public

  attr_reader :gene, :id, :exons

  def initialize(gene, id)
    raise ArgumentError, "Transcript #{id} already present." if @@ids[id]
    @gene = gene
    @id = id
    @id.freeze
    @exons = []
    @@ids[id] = self
  end

  def to_s
    rows = []
    exons.each do |exon|
      rows << ( [ @gene.chrom, 'unknown', 'exon',
                  exon.begin, exon.end,
                  '.', @gene.strand, '.',
                  "gene_id \"#{@gene.id}\"; transcript_id \"#{@id}\";" ] \
                  .join("\t") )
    end
    rows.join "\n"
  end

end



class AnnotatedGene

private

  # Store at class level all the gene ids.
  @@ids = {}

public

  attr_reader :id, :chrom, :strand, :transcripts

  def initialize(id, chrom, strand)
    raise ArgumentError, "Gene ID #{id} already present." if @@ids[id]
    raise ArgumentError, "Strand must be either + o -. Given: #{strand}." if (strand != "+" and strand != "-")
    @id = id
    @chrom = chrom
    @strand = strand
    @id.freeze
    @chrom.freeze
    @strand.freeze
    @transcripts = {}
    @@ids[id] = self
  end

  ## Convenience method
  def add_new_transcript(transcript_id)
    raise ArgumentError, "Transcript ID not specified." if not transcript_id
    result = AnnotatedTranscript.new self, transcript_id
    @transcripts[transcript_id] = result
    result
  end

  def to_s
    blocks = []
    @transcripts.each_value do |transcript|
      blocks << transcript.to_s
    end
    blocks.join "\n"
  end

end



## Execute only if it is called directly (not if 'required' by another file)
if __FILE__==$0

  g1 = AnnotatedGene.new "gene1 ", "chr22", "+"

  ## The following statements produce errors (expected)
  # g1bis = AnnotatedGene.new "gene1 ", "chr22", "+"
  # g1ter = AnnotatedGene.new "gene1ter", "chr22", "+1"
  # g1.id.strip!

  g1t1 = g1.add_new_transcript "g1t1"
  g1t1.exons << (100..200) << (250..280) << (300..400)

  g1t2 = g1.add_new_transcript "g1t2"
  g1t2.exons << (100..200) << (300..400)

  g1t3 = g1.add_new_transcript "g1t3"
  g1t3.exons << (100..200)

  puts g1

end
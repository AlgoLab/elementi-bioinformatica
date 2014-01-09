###
#
# Solution of lab assignment 8a (http://git.io/elem-bioinf-lab8#3)
# Course: "Elementi di Bioinformatica" (http://algolab.eu/didattica/elementi-di-bioinformatica/)
# Corso di Laurea in Informatica (BSc in Computer Science)
# Univ. degli Studi di Milano-Bicocca, Milan, Italy
# Academic year: 2013/14
#
# Copyright 2013-2014 Yuri Pirola (http://algolab.eu/pirola)
#
# This work is licensed under the Creative Commons Attribution 3.0
# Unported License. To view a copy of this license, visit
# http://creativecommons.org/licenses/by/3.0/
#
###


require 'bio-ensembl-rest'
include EnsemblRest
STRAND_MAPPING = { 1 => '+', -1 => '-' }.freeze

require_relative 'ex-4a-annotgene'
require_relative 'ex-7b-draw-transcripts'


def fetch_ensembl_annotated_genes(region, species='Homo sapiens')
  # Prepare connection
  EnsemblRest.connect_db
  # Fetch genes, transcripts, and exons of the given region
  feats = Features.feature_region(species, region,
                                  %w(gene transcript exon),
                                  response: 'ruby')
  # Create the genes
  genes = {}
  feats.select { |f| f['feature_type'] == 'gene' }.each do |feat|
    genes[feat['ID']] = AnnotatedGene.new(feat['ID'],
                                          feat['seq_region_name'],
                                          STRAND_MAPPING[feat['strand']])
  end
  # Create the transcripts (and keep mapping transcripts -> genes)
  transcr2gene = {}
  feats.select { |f| f['feature_type'] == 'transcript' }.each do |feat|
    raise RuntimeError, "Gene #{feat['Parent']} of transcript #{feat['ID']} has not been returned." unless genes.has_key? feat['Parent']
    gene = genes[feat['Parent']]
    transcr = gene.add_new_transcript feat['ID']
    transcr2gene[transcr.identifier] = gene
  end
  # Create the exons
  transcr2exons = Hash.new { |hash,key| hash[key] = {} }
  feats.select { |f| f['feature_type'] == 'exon' }.each do |feat|
    raise RuntimeError, "Transcript #{feat['Parent']} of exon #{feat['ID']} has not been returned." unless transcr2gene.has_key? feat['Parent']
    transcr2exons[feat['Parent']][feat['rank'].to_i] = (feat['start']-16249999)..(feat['end']-16249999)
  end
  transcr2exons.each do |transcr_id, exon_dict|
    exon_array = exon_dict.sort.map {|k,v| v }
    gene = transcr2gene[transcr_id]
    gene.transcripts[transcr_id].exons.concat exon_array
  end
  genes
end

## Execute only if it is called directly (not if 'required' by another file)
if __FILE__==$0

  REGION='21:17102000..17350000'
  genes = fetch_ensembl_annotated_genes(REGION)

  gd = AnnotatedGeneDrawer.new
  genes.each_value do |gene|
    gd.add_gene(gene)
  end

  gd.write('out-8a.svg')

end

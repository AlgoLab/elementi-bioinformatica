###
#
# Solution of lab assignment 7b (http://git.io/elem-bioinf-lab7#13)
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


require 'bio-svgenes'
require_relative 'ex-7-bio-svgenes-patches'

require_relative 'ex-4a-annotgene'
require_relative 'ex-4c-gtfreader'

class AnnotatedGeneDrawer
private

  @@FILL_COLOR = 'white'.freeze
  @@LINE_COLOR = 'black'.freeze

public

  def initialize(width = 1200, height = 10,
                 number_of_intervals = 10,
                 background_color = 'white')
    @p =
      Bio::Graphics::Page.new(:width => width,
                              :height => height,
                              :number_of_intervals => number_of_intervals,
                              :background_color => background_color
                              )
  end

  def add_gene(annot_gene)
    track = @p.add_track(:glyph => :transcript,
                         :name => annot_gene.id,
                         :label => true,
                         :exon_fill_color => @@FILL_COLOR,
                         :line_color => @@LINE_COLOR,
                         :gap_marker => 'angled',
                         :feature_height => 25)

    annot_gene.transcripts.each_value do |transcript|
      add_transcript(track, transcript)
    end
    self
  end

  def write(filename)
    @p.write(filename)
    self
  end

private

  def add_transcript(track, transcript)
    exon_coords = []
    transcript.exons.each do |exon|
      exon_coords << exon.begin << exon.end
    end
    exon_coords.sort!
    feat_transcr =
      Bio::Graphics::MiniFeature.new(:start => exon_coords.min,
                                     :end => exon_coords.max,
                                     :exons => exon_coords,
                                     :strand => transcript.gene.strand,
                                     :id => transcript.identifier)
    track.add(feat_transcr)
    track
  end

end


## Execute only if it is called directly (not if 'required' by another file)
if __FILE__==$0

  genes = GTFReader.read('./ex-7.gtf')

  gd = AnnotatedGeneDrawer.new
  genes.each_value do |gene|
    gd.add_gene(gene)
  end

  gd.write('out-7b.svg')

end

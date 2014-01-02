###
#
# Demo of the gem 'bio-svgenes' by Graham Etherington and Dan MacLean
#
# Solution of lab assignment 7a (http://git.io/elem-bioinf-lab7#6)
# Course: "Elementi di Bioinformatica" (http://algolab.eu/didattica/elementi-di-bioinformatica/)
# Corso di Laurea in Informatica (BSc in Computer Science)
# Univ. degli Studi di Milano-Bicocca, Milan, Italy
# Academic year: 2013/14
#
# This file has been adapted by Yuri Pirola (http://algolab.eu/pirola)
# from the original example by Dan MacLean available at
# https://github.com/danmaclean/bioruby-svgenes/blob/v0.3.3/examples/example.rb
#
###

##A very straightforward example that creates all the features and tracks explicitly.

require 'bio-svgenes'
require_relative 'ex-7-bio-svgenes-patches'

##create the page
p = Bio::Graphics::Page.new(:width => 1000,
             :height => 200,
             :number_of_intervals => 10
             )

##add a generic glyph track
generic_track = p.add_track(:glyph => :generic,
                            :name => 'generic_features',
                            :label => true  )

##and some features
feature1 = Bio::Graphics::MiniFeature.new(:start => 923, :end => 2212, :strand => '+', :id => "MyFeature")
generic_track.add(feature1)
feature2 = Bio::Graphics::MiniFeature.new(:start => 467, :end => 1234)
generic_track.add(feature2)
feature2 = Bio::Graphics::MiniFeature.new(:start => 12000, :end => 12330)
generic_track.add(feature2)
feature2 = Bio::Graphics::MiniFeature.new(:start => 12000, :end => 12330)
generic_track.add(feature2)
feature2 = Bio::Graphics::MiniFeature.new(:start => 12000, :end => 12330)
generic_track.add(feature2)


directed_track = p.add_track(:glyph => :directed,
                             :name => 'directed_features',
                             :label => true,
                             :feature_height => 24)

feature2 = Bio::Graphics::MiniFeature.new(:start => 467, :end => 1234, :strand => '+')
directed_track.add(feature2)
feature1 = Bio::Graphics::MiniFeature.new(:start => 923, :end => 2212, :strand => '-')
directed_track.add(feature1)


transcript_track = p.add_track(:glyph => :transcript,
                               :name => 'transcripts (grouped models)',
                               :label => true,
                               :exon_fill_color => 'green',
                               :utr_fill_color =>
                                {:type => :radial, :id => :custom,
                                 :cx => 5,  :cy => 5,  :r => 50,
                                 :fx => 50, :fy => 50,
                                 :stops => [ {:offset => 0, :color => 'rgb(255,255,255)', :opacity => 0},
                                             {:offset => 100, :color => 'rgb(0,127,200)', :opacity => 1},]},
                               :line_color => 'black',
                               :feature_height => 20 )

feature3 = Bio::Graphics::MiniFeature.new(:start => 923,
                           :end => 2345,
                           :strand => '-',
                           :exons => [1000,1200,1800,2000],
                           :utrs => [923,1000,2000,2345])
transcript_track.add(feature3)

feature1 = Bio::Graphics::MiniFeature.new(:start => 467,
                           :end => 15000,
                           :exons => [1500,2500, 3000,7000, 9000,12000],
                           :utrs => [467, 1000, 13500,14000, 14400, 14900],
                           :id => 'MyTranscript')
transcript_track.add(feature1)


transcript_track = p.add_track(:glyph => :transcript,
                               :name => 'transcripts (grouped models)',
                               :label => true,
                               :exon_fill_color => :green_white_h,
                               :utr_fill_color => :blue_white_h,
                               :line_color => 'black',
                               :gap_marker => 'angled',
                               :feature_height => 20 )

feature3 = Bio::Graphics::MiniFeature.new(:start => 923,
                           :end => 2345,
                           :strand => '-',
                           :exons => [1000,1200,1800,2000],
                           :utrs => [923,1000,2000,2345])
transcript_track.add(feature3)

feature3 = Bio::Graphics::MiniFeature.new(:start => 923,
                           :end => 2345,
                           :strand => '-',
                           :exons => [1000,1200])
transcript_track.add(feature3)


feature1 = Bio::Graphics::MiniFeature.new(:start => 467,
                           :end => 15000,
                           :exons => [1500,2500, 3000,7000, 9000,12000],
                           :utrs => [467, 1000, 13500,14000])
transcript_track.add(feature1)

data_track = p.add_track(:glyph => :histogram,  #might also be :density or heatmap  ##page doesn't know how to deal with individual file types, rather page object takes a list of values (e.g bar heights) from pre-processed data source and renders those
                        :stroke_color => 'black',
                        :fill_color => 'gold',
                        :track_height => 100,
                        :name => 'data track',
                        :label => true,
                        :stroke_width => '1',
                        :x_round => 1,
                        :y_round => 1
                        )
##generate a load of data, each data point becomes a feature...
data = (400..17000).step(200) do |start|
  data_feature = Bio::Graphics::MiniFeature.new(:start => start,
                       :end => start + 199,
                       :segment_height => rand(50)
                     )
  data_track.add(data_feature)

end


p.write 'out-7a.svg'

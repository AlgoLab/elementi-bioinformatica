###
#
# Solution of lab assignment 2b (http://git.io/elem-bioinf-lab2#14)
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


require_relative 'ex-2a-dnasequence.rb'

class FASTAReader

  def initialize(file_path)
    @file_path = file_path
  end

  def each
    seq = lines = nil
    File.open(@file_path, 'r').each do |line|
      line.chomp!
      if line.start_with? '>'
        if seq
          seq.sequence = lines.join
          yield(seq)
        end
        seq = DNASequence.new line[1..-1]
        lines = []
      else
        lines << line
      end
    end
    if seq
      seq.sequence = lines.join
      yield(seq)
    end
  end

  include Enumerable

end



## Execute only if it is called directly (not if 'required' by another file)
if __FILE__==$0

  fr = FASTAReader.new('./ex-2.fa')

  longest_seq = fr.max_by {|x| x.sequence.length }

  puts "Longest sequences:"
  fr.each do |s|
    puts "#{s.identifier}: #{s.sequence.length}" if longest_seq.sequence.length==s.sequence.length
  end

  low_GC_cont = fr.min_by { |x| x.GC_content }
  puts "#{low_GC_cont.identifier} has the lowest GC content (#{low_GC_cont.GC_content})."

  seqs_with_motif = fr.count { |x| x.sequence.upcase.match "CAGCTCCAGCTCCAGC" }
  puts "#{seqs_with_motif} sequences have the motif CAGCTCCAGCTCCAGC"

end

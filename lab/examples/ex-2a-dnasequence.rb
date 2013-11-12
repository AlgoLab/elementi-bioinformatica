###
#
# Solution of lab assignment 2a (http://git.io/elem-bioinf-lab2#13)
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


class DNASequence

  attr_reader :identifier, :sequence

  def initialize(identifier, sequence=nil)
    @identifier = String.new identifier
    self.sequence= sequence  ## Use an accessor for using the check
  end

  def sequence=(seq_str)
    if seq_str
      if seq_str.count("ACGTNacgtn") == seq_str.length
        @sequence = String.new seq_str
      else
        puts "Invalid sequence! The allowed alphabet is 'ACGTNacgtn'"
      end
    end
  end

  def reverse_and_complement!
    @sequence.reverse!
    @sequence.tr! "ACGTacgt", "TGCAtgca"
    self
  end

  def reverse_and_complement
    other = DNASequence.new @identifier, @sequence
    other.reverse_and_complement!
    other
  end

  def GC_content
    Float(@sequence.count("CGcg")) / @sequence.length
  end

  def to_fasta(width=80)
    res = [">#{@identifier}"]
    0.step(@sequence.length, width).each do |i|
      res << @sequence[i, width]
    end
    res.join "\n"
  end

end



## Execute only if it is called directly (not if 'required' by another file)
if __FILE__==$0

  s1 = DNASequence.new "id1", "ACCGTaaTTtATATatgaGTAGgCT"

  puts "The following error is intentional..."
  s2 = DNASequence.new "id2", "AGGAGCTAGCTTCGATn"

  s2.sequence = "AGGAGCTAGCTTCGAT"

  puts s1
  puts s1.GC_content

  puts s2
  puts "GC content: #{s2.GC_content}"
  puts "Sequence:   #{s2.sequence}"
  puts "Rev. compl: #{s2.reverse_and_complement.sequence}"
  puts "Sequence:   #{s2.sequence}"

  puts s2.to_fasta
  puts s2.to_fasta 5

end

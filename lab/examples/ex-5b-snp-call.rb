###
#
# Solution of lab assignment 5b (http://git.io/elem-bioinf-lab5#15)
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

  puts "Putative SNPs:"
  n = 0
  bam.mpileup do |pileup|
    if pileup.non_ref_count > 0
      n = n+1
      results = [ pileup.ref_name,
                  pileup.pos,
                  pileup.coverage,
                  pileup.ref_base]
      counts = pileup.non_refs
      counts[pileup.ref_base.to_sym] = pileup.ref_count
      counts.each do |base,bcount|
        results << "#{base}:#{bcount}"
      end
      puts results.join("\t")
    end
  end

  puts "Closing file..."
  bam.close

end

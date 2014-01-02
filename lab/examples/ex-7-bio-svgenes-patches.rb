###
#
# "Monkey patch" for gem bio-svgenes (v0.4.1)
#
# Written for:
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


module Bio
  class Graphics

# "Monkey patches" method Bio::Graphics::Page#write
# in order to actually save the SVG code to a file.
    class Page
      def write(filename)
        File.open(filename, 'w') do |f|
          f.write(self.get_markup)
        end
        self
      end

    end

  end

end

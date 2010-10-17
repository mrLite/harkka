require 'rubygems'
require 'prawn'
require 'prawn/layout'
require "#{File.dirname(File.expand_path(__FILE__))}/data_parser"

module TimeTable
  class Pdf
    HEADERS = ["", "MON", "TUE", "WED", "THU", "FRI"]
    attr_reader :filename
  
    def initialize(filename)
      @filename = filename
    end
  
    def produce_pdf
      course_matrix = DataParser.new.parse_for_pdf
      
      Prawn::Document.generate(@filename, :page_size => 'A4', :page_layout => :landscape) do
        table(course_matrix, :headers => HEADERS, :border_style => :grid, :row_colors => ['dddddd', 'eeeeee']) do |table|
          table.cells.style { |cell| cell.width = 240 }
        end
      end
    end
  end
end
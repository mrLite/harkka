require 'rubygems'
require 'prawn'
require 'prawn/layout'
require "#{File.dirname(File.expand_path(__FILE__))}/data_parser"

module TimeTable
  class Pdf
    HEADERS = ["", "MA", "TI", "KE", "TO", "PE"]
    attr_reader :filename
  
    def initialize(filename)
      @filename = filename
    end
  
    def produce_pdf
      course_matrix = DataParser.new.parse_for_pdf
      
      Prawn::Document.generate(@filename, :page_size => 'A4', :page_layout => :landscape) do
        table course_matrix,
        :headers        => HEADERS,
        :border_style   => :grid,
        :row_colors     => ['dddddd', 'eeeeee'],
        :column_widths  => {0 => 45, 1 => 145, 2 => 145, 3 => 145, 4 => 145, 5 => 145} do
          row(0).style(:background_color => 'cccccc')
          column(0).style(:background_color => 'cccccc')
        end
      end
    end
  end
end
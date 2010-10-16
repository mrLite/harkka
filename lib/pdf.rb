require 'rubygems'
require 'prawn'
require 'prawn/layout'
require 'data_parser'

class Pdf
  attr_reader :filename
  def initialize(filename)
    @filename = filename
  end
  
  def produce_pdf
    course_matrix = DataParser.new.parse_for_pdf
    
    Prawn::Document.generate(@filename, :page_size => 'A4', :page_layout => :landscape) do
      table(course_matrix, :cell_style => { :padding => 12 }) do
        cells.borders = [:bottom]

        # Use the row() and style() methods to select and style a row.
        style row(0), :border_width => 2, :borders => [:bottom]

        # The style method can take a block, allowing you to customize properties
        # per-cell.
        style(columns(0..1)) { |cell| cell.borders |= [:right] }
      end
    end
  end
end
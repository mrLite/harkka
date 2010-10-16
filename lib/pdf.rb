require 'rubygems'
require 'prawn'
require 'prawn/layout'
require 'data_parser'

class Pdf
  attr_accessor :filename
  def initialize(filename)
    @filename = filename
  end
  
  def produce_pdf
    table_rows = rows_to_strings(DataParser.parse)
    table_rows.unshift ["", "MON", "TUE", "WED", "THU", "FRI"]
    
    Prawn::Document.generate(filename, :page_size => 'A4', :page_layout => :landscape) do
      table(table_rows, :cell_style => { :padding => 12 }) do
        cells.borders = [:bottom]

        # Use the row() and style() methods to select and style a row.
        style row(0), :border_width => 2, :borders => [:bottom]

        # The style method can take a block, allowing you to customize properties
        # per-cell.
        style(columns(0..1)) { |cell| cell.borders |= [:right] }
      end
    end
  end
  
  protected
  
  def rows_to_strings(matrix)
    table_matrix = matrix
    table_matrix = table_matrix.map do |table_row|
      table_row = table_row.map do |slot|
        if slot.class == Hash and slot.empty?
          slot = ""
        elsif slot.class == Hash and !slot.empty?
          slot_string = slot[:name].to_s+"\n"
          slot_string << slot[:location].to_s+"\n"
          slot_string << slot[:lecturer].to_s
          slot = slot_string
        else
          slot
        end
      end
    end
    table_matrix
  end
end
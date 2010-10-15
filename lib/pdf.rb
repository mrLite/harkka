require 'rubygems'
require 'prawn'
require 'prawn/layout'

class Pdf
  attr_accessor :text, :filename
  def initialize(text, filename)
    @text = text
    @filename = filename
  end
  
  def produce_pdf
    Prawn::Document.generate(filename, :page_size => 'A4', :page_layout => :landscape) do
      table([
      ["", "MA", "TI", "KE", "TO", "PE"], 
      ["8-10", "Laskennan mallit", "", "", "C-ohjelmointi", "Tietokoneen toiminta"], 
      ["10-12", "", "Tietokoneen toiminta", "", "", "Laskennan mallit"],
      ["12-14"], 
      ["14-16"],
      ["16-18"]
      ], :cell_style => { :padding => 12 }) do
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
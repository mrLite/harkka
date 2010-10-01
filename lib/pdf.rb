require 'rubygems'
require 'prawn'

class Pdf
  attr_accessor :text, :filename
  def initialize(text, filename)
    @text = text
    @filename = filename
  end
  
  def produce_pdf
    pdf = Prawn::Document.new
    pdf.text @text
    pdf.render_file @filename
  end
end
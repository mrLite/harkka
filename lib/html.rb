require 'erb'
require 'data_parser'

class Html
  attr_accessor :filename, :html_file
  def initialize(filename, html_file = "")
    @filename = filename
    @html_file = html_file
  end
  
  def produce_html
    html = ERB.new File.new("../config/timetable.rhtml").read, nil, "%"
    
    @table_rows = DataParser.new.parse
    
    File.open(@filename, "w") do |file|
      file.write html.result(binding)
    end
  end
end
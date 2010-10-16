require 'erb'
require 'data_parser'

class Html
  attr_accessor :filename, :html, :input_type
  def initialize(filename = "timetable.html", html = "../config/timetable.rhtml", input_type = "f")
    @filename = filename
    if input_type == "f"
      @html = ERB.new File.new(html).read, nil, "%"
    elsif input_type == "s"
      @html = html
    end
  end
  
  def produce_html    
    @table_rows = DataParser.new.parse
    
    File.open(@filename, "w") do |file|
      file.write @html.result(binding)
    end
  end
end
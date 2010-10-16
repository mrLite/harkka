require 'erb'
require "#{File.dirname(File.expand_path(__FILE__))}/data_parser"

class Html
  attr_accessor :filename, :html, :input_type
  DEFAULT_RHTML = "#{File.dirname(File.expand_path(__FILE__))}/../config/timetable.rhtml"
  
  def initialize(filename = "timetable.html", html = DEFAULT_RHTML, input_type = "f")
    @filename = filename
    if input_type == "f"
      @html = ERB.new(File.new(html).read, nil, "%")
    elsif input_type == "s"
      @html = ERB.new(html.gsub(/^  /, ''), nil, "%")
    end
  end
  
  def produce_html
    @table_rows = DataParser.new.parse
    
    File.open(@filename, "w") do |file|
      file.write @html.result(binding)
    end
  end
end
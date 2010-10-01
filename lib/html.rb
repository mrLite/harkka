require 'erb'

class Html
  attr_accessor :filename, :html_file
  def initialize(filename, html_file = "")
    @filename = filename
    @html_file = html_file
  end
  
  def produce_html
    html = File.open("../config/timetable.rhtml", "r") do |file|
      while line = file.gets
        @html_file << line
      end
    end
  
    File.open(@filename, "w") do |file|
      file.write ERB.new(@html_file).result
    end
  end
end
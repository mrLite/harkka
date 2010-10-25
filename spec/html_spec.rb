require "#{File.dirname(File.expand_path(__FILE__))}/../lib/timetable/html"
require 'erb'
require "#{File.dirname(File.expand_path(__FILE__))}/../lib/timetable/data_parser"

describe TimeTable::Html do
  it "should initialize with default values" do
    test_template = ERB.new(File.new("#{File.dirname(File.expand_path(__FILE__))}/../config/timetable.rhtml").read, nil, "%")
    html = TimeTable::Html.new
    html.html.src.should == test_template.src
    html.filename.should == "timetable.html"
  end
  
  it "should have the filename specified" do
    html = TimeTable::Html.new("test_filename.html")
    html.filename.should == "test_filename.html"
  end
  
  it "should produce a html file with the courses from the YAML file" do
    html = TimeTable::Html.new
    html.produce_html
    
    @table_rows = TimeTable::DataParser.new.parse
    
    expected_html = File.open("timetable.html", "r") do |f|
      f.read
    end
    html.html.result(binding).should == expected_html
    
    `rm timetable.html`
  end
end
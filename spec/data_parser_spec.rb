require "#{File.dirname(File.expand_path(__FILE__))}/../lib/timetable/data_parser"
require 'yaml'

describe TimeTable::DataParser do
  it "should load courses from the default yaml file" do
    test_yaml = open("config/timetable.yml") {|file| YAML.load(file) }
    #test_yaml = {"courses"=>[{"name"=>"Laskennan mallit", "times"=>[{"location"=>"A111", "time"=>"12-14", "day"=>"mon"}], "type"=>"LU", "lecturer"=>"Timo Soini"}, {"name"=>"Laskennan mallit", "times"=>[{"location"=>"Eira", "time"=>"16-18", "day"=>"wed"}], "type"=>"LH", "lecturer"=>"Jussi Allah-aho"}, {"name"=>"C-ohjelmointi", "times"=>[{"location"=>"CK112", "time"=>"14-16", "day"=>"tue"}, {"location"=>"CK112", "time"=>"10-12", "day"=>"thu"}], "type"=>"LU", "lecturer"=>"Kimmo Wilska"}, {"name"=>"Algoritmien suunnittelu ja analyysi", "times"=>[{"location"=>"underground", "time"=>"8-10", "day"=>"fri"}], "type"=>"LU", "lecturer"=>"Luis Urzua"}]}
    data_parser = TimeTable::DataParser.new
    data_parser.yaml.should == test_yaml
  end
  
  it "should load courses from a hash" do
    test_yaml = {"courses"=>[{"name"=>"Automaattinen testaus", "times"=>[{"location"=>"Ruby", "time"=>"10-12", "day"=>"tue"}], "type"=>"LU", "lecturer"=>"Ruby Guy"}]}
    data_parser = TimeTable::DataParser.new(test_yaml, "h")
    data_parser.yaml.should == test_yaml
  end
  
  it "should return a valid timetable matrix" do
    test_yaml = {"courses"=>[{"name"=>"Automaattinen testaus", "times"=>[{"location"=>"Ruby", "time"=>"10-12", "day"=>"tue"}], "type"=>"LU", "lecturer"=>"Ruby Guy"}]}
    test_matrix = [
      ["8-10", {}, {}, {}, {}, {}],
      ["10-12", {}, {:day=>"tue", :type=>"LU", :time=>"10-12", :lecturer=>"Ruby Guy", :name=>"Automaattinen testaus", :location=>"Ruby"}, {}, {}, {}],
      ["12-14", {}, {}, {}, {}, {}],
      ["14-16", {}, {}, {}, {}, {}],
      ["16-18", {}, {}, {}, {}, {}],
      ["18-20", {}, {}, {}, {}, {}]
      ]
    data_parser = TimeTable::DataParser.new(test_yaml, "h") 
    data_parser.parse.should == test_matrix
  end
  
  it "should return a matrix consisting of strings only" do
    test_yaml = {"courses"=>[{"name"=>"Automaattinen testaus", "times"=>[{"location"=>"Ruby", "time"=>"10-12", "day"=>"tue"}], "type"=>"LU", "lecturer"=>"Ruby Guy"}]}
    test_matrix = [
      ["8-10", "", "", "", "", ""],
      ["10-12", "", "Automaattinen testaus (LU)\nRuby\nRuby Guy", "", "", ""],
      ["12-14", "", "", "", "", ""],
      ["14-16", "", "", "", "", ""],
      ["16-18", "", "", "", "", ""],
      ["18-20", "", "", "", "", ""]
      ]
    data_parser = TimeTable::DataParser.new(test_yaml, "h") 
    data_parser.parse_for_pdf.should == test_matrix
  end
end
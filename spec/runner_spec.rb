require "#{File.dirname(File.expand_path(__FILE__))}/../lib/timetable/runner"

describe TimeTable::Runner do
  it "should initialize with an argument list" do
    args = ["-h"]
    runner = TimeTable::Runner.new(args)
    runner.argv.should == ["-h"]
  end
  
  it "should print the usage message and exit" do
    args = ["-h", "--usage", "--help", "-pfd"]
    usage = "Usage: ./timetable [-pdf filename] [-html filename]\nDefault output is a html file, and if no filename is given it's timetable.html"
    
    args.each do |arg|
      runner = TimeTable::Runner.new(arg)
      lambda { runner.run }.should raise_error SystemExit, usage
    end
  end
  
  it "should output a html file" do
    runner = TimeTable::Runner.new(["-html", "test_file.html"])
    runner.run
    test_file = File.open("test_file.html", "r") do |f|
      f.read
    end
    `rm test_file.html` if test_file
  end
  
  it "should output a pdf file" do
    runner = TimeTable::Runner.new(["-pdf", "test_file.pdf"])
    runner.run
    test_file = File.open("test_file.pdf", "r") do |f|
      f.read
    end
    `rm test_file.pdf` if test_file
  end
end
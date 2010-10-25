require "#{File.dirname(File.expand_path(__FILE__))}/../lib/timetable/runner"

describe TimeTable::Runner do
  it "should initialize with an argument list" do
    args = ["-h"]
    runner = TimeTable::Runner.new(args)
    runner.argv.should == ["-h"]
  end
  
  it "should print the usage message and exit" do
    args = ["-h"]
    usage = "Usage: ./timetable [-pdf] [filename] [-html] [filename]\nDefault output is a html file, and if no filename is given it's timetable.html"
    
    runner = TimeTable::Runner.new(args)
    lambda { runner.run }.should raise_error SystemExit
  end
end
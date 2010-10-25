require "#{File.dirname(File.expand_path(__FILE__))}/../lib/timetable/pdf"

describe TimeTable::Pdf do
  it "should initialize with given filename" do
    pdf = TimeTable::Pdf.new("test_pdf.pdf")
    pdf.filename.should == "test_pdf.pdf"
  end
end
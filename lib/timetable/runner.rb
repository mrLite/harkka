require "#{File.dirname(__FILE__)}/pdf"
require "#{File.dirname(__FILE__)}/html"

module TimeTable
  class Runner
    USAGE = "Usage: ruby timetable.rb [-pdf] [filename] [-html] [filename]\n"
    USAGE << "Default output is a html file, and if no filename is given it's timetable.html"
    attr_reader :argv
    
    def initialize(argv)
      @argv = argv
    end
    
    def run
      if @argv and !@argv.empty?
        unless @argv.include? "-pdf" or @argv.include? "-html"
          puts USAGE
          Kernel.exit
        end
      end
  
      if (pdf_index = ARGV.index "-pdf")
        pdf_filename = ARGV[pdf_index+1]
    
        if pdf_filename and pdf_filename != "-html"
          puts "pdf-tiedosto: #{pdf_filename}"
      
          pdf_file = Pdf.new(pdf_filename)
          pdf_file.produce_pdf
        end
      end
  
      if (html_index = ARGV.index "-html")
        html_filename = ARGV[html_index+1]
    
        if html_filename and html_filename != "-pdf"
          puts "html-tiedosto: #{html_filename}"
      
          html_file = Html.new(html_filename)
          html_file.produce_html
        end
      end
    end
  end
end
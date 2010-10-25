require "#{File.dirname(File.expand_path(__FILE__))}/pdf"
require "#{File.dirname(File.expand_path(__FILE__))}/html"

module TimeTable
  class Runner
    USAGE = "Usage: ./timetable [-pdf filename] [-html filename]\n"
    USAGE << "Default output is a html file, and if no filename is given it's timetable.html"
    attr_reader :argv
    
    def initialize(argv)
      @argv = argv
    end
    
    def run
      if @argv.empty?
        puts "html-tiedosto: timetable.html"
        html_file = Html.new
        html_file.produce_html
      elsif @argv and @argv.include? "-h" or @argv.include? "--help" or @argv.include? "--usage"
        puts USAGE
        Kernel.exit
      elsif @argv and !@argv.empty?
        unless @argv.include? "-pdf" or @argv.include? "-html"
          puts USAGE
          Kernel.exit
        else
          output_html
          output_pdf
        end
      end
    end
    
    private
    
    def output_pdf
      if (pdf_index = @argv.index "-pdf")
        pdf_filename = @argv[pdf_index+1]
        
        if !pdf_filename or pdf_filename == "-html"
          puts USAGE
          exit(0)
        elsif pdf_filename and pdf_filename != "-html"
          puts "pdf-tiedosto: #{pdf_filename}"
          pdf_file = Pdf.new(pdf_filename)
          pdf_file.produce_pdf
        end
      end
    end
    
    def output_html
      if (html_index = @argv.index "-html")
        html_filename = @argv[html_index+1]
        
        if !html_filename or html_filename == "-pdf"
          puts USAGE
          exit(0)
        elsif html_filename and html_filename != "-pdf"
          puts "html-tiedosto: #{html_filename}"
          html_file = Html.new(html_filename)
          html_file.produce_html
        end
      end
    end
  end
end
require 'pdf'
require 'html'

module TimeTable
  USAGE = "Usage: ruby timetable.rb [-pdf] [filename] [-html] [filename]\n"
  USAGE << "Default output is a html file, and if no filename is given it's timetable.html"
  
  ARGV.each do |arg|
    unless arg =~ /\A-pdf\Z|\A-html\Z/
      if arg =~ /\A-/
        puts USAGE
        Kernel.exit
      end
    end
  end
  
  if (pdf_index = ARGV.index "-pdf")
    pdf_filename = ARGV[pdf_index+1]
    
    if pdf_filename and pdf_filename != "-html"
      puts "pdf-tiedosto: #{pdf_filename}"
      
      pdf_file = Pdf.new("PDF-tiedostoon.", pdf_filename)
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
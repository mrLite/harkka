require 'pdf'
require 'html'

module TimeTable
  USAGE = "Usage: ruby timetable.rb [-pdf] [filename.pdf] [-html] [filename.html]\n"
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
    end
  end
  
  if (html_index = ARGV.index "-html")
    html_filename = ARGV[html_index+1]
    
    if html_filename and html_filename != "-pdf"
      puts "html-tiedosto: #{html_filename}"
    
      File.open(html_filename, 'w') do |file|
        file.write "kirjoitetaan html-tiedostoon."
      end
    end
  end
end
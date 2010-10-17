require 'yaml'

module TimeTable
  class DataParser
    attr_reader :config_type
    attr_accessor :yaml
    DEFAULT_YAML = "#{File.dirname(File.expand_path(__FILE__))}/../../config/timetable.yml"
  
    def initialize(yaml = DEFAULT_YAML, config_type = "f")
      if config_type == "f"
        @yaml = open(yaml) {|file| YAML.load(file) }
      elsif config_type == "h"
        @yaml = yaml
      end
    end
  
    def parse      
      timetable_courses = []
      @yaml['courses'].each do |course|
        course['times'].each do |time|
          timetable_courses << {:name => course['name'], :lecturer => course['lecturer'], :type => course['type'], :day => time['day'], :time => time['time'], :location => time['location']}
        end
      end
    
      @timetable_matrix = [
        ["8-10", {}, {}, {}, {}, {}],
        ["10-12", {}, {}, {}, {}, {}],
        ["12-14", {}, {}, {}, {}, {}],
        ["14-16", {}, {}, {}, {}, {}],
        ["16-18", {}, {}, {}, {}, {}],
        ["18-20", {}, {}, {}, {}, {}]
        ]
    
      timetable_courses.each do |row|
        begin
          index_on_matrix row
        rescue Exception => e
          STDERR.puts "ERROR! Ohitettiin kurssi: #{course[:name]} (#{course[:day]} #{course[:time]}). " + "Tarkista yaml-tiedoston syntaksi."
        end
      end
    return @timetable_matrix
    end
  
    def parse_for_pdf
      table_rows = rows_to_strings(self.parse)
    end
  
    private
  
    def index_on_matrix(course)
      rows = {"8-10" => 0, "10-12" => 1, "12-14" => 2, "14-16" => 3, "16-18" => 4, "18-20" => 5 }
      columns = {"mon" => 1, "tue" => 2, "wed" => 3, "thu" => 4, "fri" => 5}
      x = rows[course[:time]]
      y = columns[course[:day]]
      @timetable_matrix[x][y] = course
    end
  
    def rows_to_strings(matrix)
      table_matrix = matrix
      table_matrix = table_matrix.map do |table_row|
        table_row = table_row.map do |slot|
          if slot.class == Hash and slot.empty?
            slot = ""
          elsif slot.class == Hash and !slot.empty?
            slot_string = slot[:name].to_s+" ("+slot[:type]+")"+"\n"
            slot_string << slot[:location].to_s+"\n"
            slot_string << slot[:lecturer].to_s
            slot = slot_string
          else
            slot
          end
        end
      end
      table_matrix
    end
    
  end
end
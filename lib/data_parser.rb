require 'yaml'

module DataParser
  def DataParser.parse
    timetable_rows = []
  
    timetable = open('../config/timetable.yml') {|file| YAML.load(file) }
  
    timetable['courses'].each do |course|
      course['times'].each do |time|
        timetable_rows << {:name => course['name'], :lecturer => course['lecturer'], :day => time['day'], :time => time['time'], :location => time['location']}
      end
    end
    
    timetable_rows
  end
end
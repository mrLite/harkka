require 'yaml'

module DataParser
  def DataParser.parse  
    timetable = open('../config/timetable.yml') {|file| YAML.load(file) }
    
    timetable_courses = []
    
    timetable['courses'].each do |course|
      course['times'].each do |time|
        timetable_courses << {:name => course['name'], :lecturer => course['lecturer'], :day => time['day'], :time => time['time'], :location => time['location']}
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
      DataParser.index_on_matrix row
    end
  return @timetable_matrix
  end
  
  private
  
  def DataParser.index_on_matrix(course)
    rows = {"8-10" => 0, "10-12" => 1, "12-14" => 2, "14-16" => 3, "16-18" => 4, "18-20" => 5 }
    columns = {"mon" => 1, "tue" => 2, "wed" => 3, "thu" => 4, "fri" => 5}
    x = rows[course[:time]]
    y = columns[course[:day]]
    @timetable_matrix[x][y] = course
  end
end
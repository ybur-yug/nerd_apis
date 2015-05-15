class DatatauTask < Volt::Task
  def datatau 
    JSON.parse(Mechanize.new.get('http://localhost:4567/datatau').content) 
  end
end

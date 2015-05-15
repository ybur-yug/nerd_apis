class ProggitTask < Volt::Task
  def proggit 
    JSON.parse(Mechanize.new.get('http://localhost:4567/proggit').content) 
  end
end

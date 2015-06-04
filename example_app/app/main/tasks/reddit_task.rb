require 'mechanize'

class RedditTask < Volt::Task
  def reddit
    JSON.parse(Mechanize.new.get('http://localhost:4567/reddit')
  end
end

require 'mechanize'

class LobsterTask < Volt::Task
  def lobsters
    JSON.parse(Mechanize.new.get('http://localhost:4567/lobsters/frontpage/1').content) 
  end
end


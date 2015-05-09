require 'sinatra'
require "json"
require 'mechanize'

# Base Module and Classes
module Lobsters
  class Scraper
    attr_accessor :browser
    attr_accessor :lobsters_urls
    def initialize
      @browser = Mechanize.new { |config| config.user_agent_alias = "Mac Safari" }
      @lobsters_urls = {
        frontpage: "http://lobste.rs",
        recent:    "http://lobste.rs/recent/",
        search:    "http://lobste.rs/search/"
      }
    end

    def frontpage
      parse_page(@browser.get(lobsters_urls[:frontpage]))
    end

    def recent 
      parse_page(@browser.get(lobsters_urls[:recent]))
    end
    
    def search query_string
      parse_page(@browser.get(get_query_url(query_string)))
    end
    private
    def get_query_url query_string, what="all", order="relevence"
      terms = query_string.gsub!(" ", "+") 
      "https://www.lobste.rs/search/?q=#{terms}&what=#{what}&order=#{order}?"
    end

    def parse_page page
      begin
        { results: page.search(".details").map { |l| { title: l.at("a").text, 
                                                       link:l.at("a").attributes['href'].value } 
                                                     } 
                                               }.to_json
      rescue 
        { error: "Page parsing error" }.to_json
      end
    end
  end

  class Api
    attr_accessor :scraper 
    def initialize
      @scraper = Scraper.new
    end

    def frontpage
      @scraper.frontpage
    end

    def recent 
      @scraper.recent
    end
    
    def search query
      @scraper.search query
    end
  end
end


# API Code
api = Lobsters::Api.new

set :server, 'webrick'

get '/recent' do
  api.recent
end

get '/frontpage' do
  api.frontpage
end

post '/search' do
  begin 
    terms = JSON.parse(request.body.read)
    api.search terms[terms.keys.first] # get first key if it doesnt match 'terms' anyway
  rescue
    status 400
    body "invalid JSON format"
  end
end


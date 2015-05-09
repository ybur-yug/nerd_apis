require 'sinatra'
require "json"
require 'mechanize'

module Lobsters
  class Scraper
    attr_accessor :browser
    attr_accessor :lobsters_urls
    def initialize
      @browser = Mechanize.new
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

    private
    def get_query_url query_string, what="all", order="relevence"
      terms = query_string.gsub!(" ", "+") 
      query_url = "https://www.lobste.rs/search/?q=#{terms}&what=#{what}&order=#{order}?"
    end

    def parse_page page
      begin
        page.search(".details").map { |l| l.at("a").text }
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

api = Lobsters::Api.new

set :server, 'webrick'

get '/' do
  "hello world"
end

get '/recent' do
  api.recent
end

get '/frontpage' do
  api.frontpage
end



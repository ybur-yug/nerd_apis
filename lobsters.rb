require 'sinatra'
require 'json'
require 'mechanize'

# Base Module and Classes
module Lobsters
  # A module to wrap/scrape Lobste.rs as a REST API
  class Scraper
    # A Simple Scraper
    attr_accessor :browser
    attr_accessor :lobsters_urls
    def initialize
      @browser = Mechanize.new { |conf| conf.user_agent_alias = 'Mac Safari' }
      @lobsters_urls = {
        frontpage: 'http://lobste.rs',
        recent:    'http://lobste.rs/recent/',
        search:    'http://lobste.rs/search/'
      }
    end

    def frontpage(page)
      if page != '1'
        parse_page(@browser.get("#{lobsters_urls[:frontpage]}/page/#{page}"))
      else
        parse_page(@browser.get("#{lobsters_urls[:frontpage]}"))
      end
    end

    def recent(page)
      if page != '1'
        parse_page(@browser.get("#{lobsters_urls[:recent]}/page/#{page}"))
      else
        parse_page(@browser.get("#{lobsters_urls[:recent]}"))
      end
    end

    def search(query_string)
      parse_page(@browser.get(get_query_url(query_string)))
    end

    private

    def get_query_url(query_string, what = 'all', order = 'relevence')
      terms = query_string.gsub!(' ', '+')
      "https://www.lobste.rs/search/?q=#{terms}&what=#{what}&order=#{order}?"
    end

    def parse_page(page)
      begin
        { results: page.search('.details').map { |l|
                                                 { title: l.at('a').text,
                                                   link: l.at('a').attributes['href'].value,
                                                   submitter: l.at('.byline').at('a').attributes['href'].value,
                                                   submission_dt: l.at('label').attributes['title'].value }
                                                 }
                                               }.to_json
      rescue
        { error: 'Page parsing error' }.to_json
      end
    end
  end

  # A simple API class to wrap lobste.rs
  class Api
    attr_accessor :scraper
    def initialize
      @scraper = Scraper.new
    end

    def frontpage(page = 1)
      if page 
        @scraper.frontpage(page)
      else
        @scraper.frontpage
      end
    end

    def recent(page = 1)
      @scraper.recent(page)
    end

    def search(query)
      @scraper.search query
    end
  end
end

# API Code
api = Lobsters::Api.new

set :server, 'webrick'


get '/recent/:page' do
  if params['page'] != '1'
    api.recent(params['page'])
  else 
    api.recent
  end
end
get '/frontpage/:page' do
  if params['page'] != '1'
    api.frontpage(params['page'])
  else 
    api.frontpage
  end
end

post '/search' do
  begin
    terms = JSON.parse(request.body.read)
    api.search terms[terms.keys.first] # get the first key always
  rescue
    status 400
    body 'invalid JSON format'
  end
end

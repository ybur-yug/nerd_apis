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

    def frontpage2(page)
      page ||= 1
      parse_page(@browser.get("#{@lobsters_urls[:frontpage]}/page/#{page}"))
    end

#    def frontpage(page)
#      parse_page(@browser.get("#{lobsters_urls[:frontpage]}/page/#{page}"))
#    end
#
#    def recent(page)
#      if page != '1'
#        parse_page(@browser.get("#{lobsters_urls[:recent]}/page/#{page}"))
#      else
#        parse_page(@browser.get("#{lobsters_urls[:recent]}"))
#      end
#    end
#
#    def search(query_string, what, page, _order = 'relevence')
#      if page != '1'
#        parse_page(@browser.get(get_query_url(query_string, what,
#                                              page, relevence)))
#      else
#        parse_page(@browser.get(get_query_url(query_string, what,
#                                              relevence)))
#      end
#    end

    def sign_in(email, password)
      page = @browser.get('https://lobste.rs/login')
      page.form['email'] = email
      page.form['password'] = password
      parse_page(page.form.submit!)
    end

    private

    def get_query_url(query_string, what, page = nil, order)
      terms = query_string.gsub!(' ', '+')
      if page
        "https://www.lobste.rs/search/?q=#{terms}&what=#{what}&order=#{order}"
        "&page=#{page}?"
      else
        "https://www.lobste.rs/search/?q=#{terms}&what=#{what}&order=#{order}?"
      end
    end

    def parse_page(page)
      { results: page.search('.details')
                 .map { |l| Entry.new(l) }
                     }.to_json
    rescue
      { error: 'Page parsing error' }.to_json
    end
  end

  class Entry
    def initialize(div)
      @div = div 
    end

    def title
      div.at('a').text
    end

    def link
      div.at('a')
         .attributes['href'].value
    end

    def submitter
      div.at('.byline')
         .at('a')
         .attributes['href'].value
    end

    def submission_dt
      div.at('label')
         .attributes['title'].value
    end

    def to_json(*args)
      {
        title: title,
        link: link,
        submitter: submitter,
        submission_dt: submission_dt
      }.to_json
    end

    private

    attr_reader :div
  end

  # A simple API class to wrap lobste.rs
  class Api
    require 'hobos'
    attr_accessor :scraper

    def initialize
      @scraper = Scraper.new
    end

    def frontpage2(page)
      @scraper.frontpage2(page)
    end

#    def frontpage(page = 1)
#      if page
#        @scraper.frontpage(page)
#      else
#        @scraper.frontpage
#      end
#    end

    def recent(page = 1)
      @scraper.recent(page)
    end

    def search(query, page = 1, what = 'all', order = 'relevence')
      @scraper.search(query, what, page, order)
    end

    def sign_in(email, password)
      # returns frontpage as signed in user, minimal to start
      @scraper.sign_in(email, password)
    end
  end
end

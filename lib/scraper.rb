require 'mechanize'

require_relative 'stories'
  
URLS = { 
    proggit:  { frontpage: 'http://programming.reddit.com/' },
    datatau:  { frontpage: 'http://www.datatau.com' },
    lobsters: { frontpage: 'http://lobste.rs/',
                recent: 'http://lobste.rs/recent/',
                search: 'http://lobste.rs/search/' }

}

module Scraper
  class Lobsters
    attr_accessor :browser

    def initialize
      @urls = URLS[:lobsters]
      @browser = Mechanize.new
    end

    def frontpage(page)
      parse_page(@browser.get("#{@urls[:frontpage]}page/#{page}"))
    end

    def recent(page)
      parse_page(@browser.get("#{@urls[:recent]}page/#{page}"))
    end
    
    def parse_page(page)
      { results: page.search('.details')
                 .map { |link| Stories::LobstersStory.new(link) }
      }.to_json
    rescue
      { error: 'Page parsing error' }.to_json
    end
  end

  class Proggit
    def initialize
      @urls = URLS[:proggit]
      @browser = Mechanize.new
    end

    def frontpage
      frontpage = @browser.get(@urls[:frontpage])
      links = frontpage.links.map { |link|
        link if link.dom_class == 'title may-blank '
      }.compact!
      parse_page(links)
    end

    def parse_page(links)
      { results: links.map { |link| Stories::ProggitStory.new(link) } }.to_json
    end
  end

  class DataTau
    def initialize
      @urls = URLS[:datatau]
      @browser = Mechanize.new
    end

    def frontpage
      frontpage = @browser.get(@urls[:frontpage])
      links = frontpage.search('.title').map { |node|
        node.at('a')
      }.compact!
      parse_page(links).to_json
    end

    def parse_page(links)
      { results: links.map { |link|
        Stories::DataTauStory.new(link) }
      }
    end
  end
end

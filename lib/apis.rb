require 'json'
require 'mechanize'

require_relative 'scraper'

module Apis
  class LobstersApi
    attr_accessor :scraper

    def initialize
      @scraper = Scraper::Lobsters.new
    end

    def frontpage(page)
      @scraper.frontpage(page)
    end
  end
end

require 'json'

require_relative 'scraper'

module Apis
  class Lobsters
    attr_accessor :scraper

    def initialize
      @scraper = Scraper::Lobsters.new
    end

    def frontpage(page)
      page ||= 1
      @scraper.frontpage(page)
    end

    def recent(page)
      page ||= 1
      @scraper.recent(page)
    end
  end
end

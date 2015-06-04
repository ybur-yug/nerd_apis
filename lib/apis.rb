require 'json'

require_relative 'scraper'

module Apis
  class Proggit
    def initialize
      @scraper = Scraper::Proggit.new
    end

    def frontpage
      @scraper.frontpage
    end
  end

  class Reddit
    def initialize
      @scraper = Scraper::Reddit.new
    end

    def frontpage
      @scraper.frontpage
    end
  end


  class Lobsters
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

  class DataTau
    def initialize
      @scraper = Scraper::DataTau.new
    end

    def frontpage
      @scraper.frontpage
    end
  end
end

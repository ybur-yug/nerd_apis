module Stories
  class ProggitStory
    def initialize(link)
      @div = link
    end

    def title
      div.attributes.text
    end

    def link
      div.uri.to_s
    end

    def submitter
      ""
    end

    def submission_dt
      ""
    end

    def to_json(*args)
      {
        title: title,
        link: link,
      }.to_json
    end

    private

    attr_reader :div
  end

  class LobstersStory 
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

  class DataTauStory
    def initialize(div)
      @div = div
    end

    def title 
      div.text
    end

    def link
      div.attributes['href']
    end

    def to_json(*args)
      {
        title: title,
        link: link
      }.to_json
    end

    private

    attr_reader :div
  end
end

module Stories
  class RedditStory
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
end

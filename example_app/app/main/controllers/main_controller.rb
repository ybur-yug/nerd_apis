# By default Volt generates this controller for your Main component
module Main
  class MainController < Volt::ModelController
    def index
      LobsterTask.lobsters
      .then do |stories|
        page._lobsters = stories
      end.fail do |error|
        page._stories = error
      end
      ProggitTask.proggit
      .then do |stories|
        page._proggit = stories
      end.fail do |error|
        page._proggit_error = error
      end
      RedditTask.reddit
      .then do |stories|
        page._reddit = stories
      end.fail do |error|
        page._reddit_error = error
      end
      DatatauTask.datatau
      .then do |stories|
        page._datatau = stories
      end.fail do |error|
        page._dt_error = error
      end
    end

    def about
      # Add code for when the about view is loaded
    end

    private

    # The main template contains a #template binding that shows another
    # template.  This is the path to that template.  It may change based
    # on the params._component, params._controller, and params._action values.
    def main_path
      "#{params._component || 'main'}/#{params._controller || 'main'}/#{params._action || 'index'}"
    end

    # Determine if the current nav component is the active one by looking
    # at the first part of the url against the href attribute.
    def active_tab?
      url.path.split('/')[1] == attrs.href.split('/')[1]
    end
  end
end

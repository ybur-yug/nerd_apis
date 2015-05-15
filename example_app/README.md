# Making an Unofficial Lobste.rs API Volt App 

## Getting Started
First, let's get a basic application set up. I will assume you've already dug around a simple project, but if you
are completely new to Volt I would recommend reading through the documentation [here](http://docs.voltframework.com).
We create a project with a simple

`volt new project_name`

And it will bundle automatically. However, if you prefer to bundle to a local path like I do using:

`bundle --path vendor/bundle`

This is what you should see after creating your first application:

Now that we have a project, we can fire up our server and have the application start to run. One of the best things about
development in Volt is the server will automatically reload your new code. So, start a server in a separate terminal and 
proceed to generate a task now. 

(in a new terminal)
`bundle exec volt s`

(in the original)
`bundle exec volt g task lobsters`

So we have a Volt task, and the relevent spec. Let's open up the default task file and check it out:

```RUBY
class LobstersTask < Volt::Task

end
```

Now, lets add some code to get information from the backend using this task we have generated. Volt tasks exclusively run
asynchronously on the backend. We need mechanize so we should throw that in our Gemfile, too.

```RUBY
...
gem 'mechanize'
...
```

```RUBY
require 'mechanize' # top level or inside the class, doesnt matter
...
  def lobsters
    JSON.parse(Mechanize.new.get('http://localhost:4567/frontpage/1').content)
  end
...
```

Now, this method is an instance level method. However, to call it in our controller Volt has a slightly different convention
than the norm when it comes to invoking this. It is also worth noting that even though we are writing it as a Ruby hash, it 
will be coerced into a Volt model on the frontend. This becomes an important detail 

If we navigate to our controller, we can begin to handle the output from this.

```RUBY
module Main
  class MainController < Volt::ModelController
    def index
      LobstersTask.lobsters
      .then do |stories|
        page._results = stories
      end.fail do |err|
        page._results = err
      end
    end
    ...
   end
end
```

Now if we go to our client code in `app/main/views/main/index.html`, we will creat a `page._lobsters` Volt model we can access these parameters from. 
Note that is is accessed with a `_` prepended. This is another Volt convention.

Now we just go into our `index.html` for `main` and we can add some logic to display our stories.

```RUBY
...
  {{ page._lobsters._results.each do |story|
    <h4><a href='{{ story._url }}'>
    {{ story._title }}</a></h4>
  {{ end }}
...
```

And now we've successfully executed code on only the server, and fed it to the client once the task was completed
communicating both with 3rd party API's and our own server. 

Happy Hacking.

# Unofficial Nerd APIs

## In the Wild
The example application in the `example_app` directory hits all 3 of these API's locally and displays the link.
There is a tutorial on getting the basic functionality included in the README.
In order to just get it to run, do the following:

`bundle`
`bundle exec volt s`

And navigate to `localhost:3000`

![Volt Application](http://i.imgur.com/FwrPwKi.png)

## Structure
#### lib/scraper.rb
This is intended to incapsulate the scraper for each site being API-ified

#### lib/apis.rb
The module containing each individual API. The goal of this module/its classes is to have a minimal LOC setup for the APIs made.

#### lib/stories.rb
This wraps the JSON that we hope to return in a Rubyish OO manner for maximum separation from the business logic of the
scraping operations performed

#### server.rb
This contains the server itself, a simple sinatra/rack application

## Routes
`/lobsters/frontpage/:page` GET

`lobsters/recent/:page` GET

`/reddit` GET

`/datatau` GET

## Usage
It is a simple Rack app. In order to run it, if you fancy Heroku one must simple do the following:

```BASH
$ bundle install
$ heroku create
$ git push heroku master
```



## Todos
- Better response codes + routing/error handling
- Utilize Mechanize's cookie jar to get the cookie that can filter displayed stories
- View comments
- Allow user login and profile updating
- Mock tests with VCR or webmock (simpler alternative)
- (and much more)

## Contributing
1. Fork, and make a branch
2. Code!
3. Test!
4. PR!


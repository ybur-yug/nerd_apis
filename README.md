# Lobste.rs Unofficial API

## Example Application
You can find a Volt app hitting this api [here](https://github.com/ybur-yug/volt_task_example).

## Structure
#### lib/scraper.rb
This is intended to incapsulate the scraper for each site being API-ified (for now, only lobste.rs but in the future reddit)

#### lib/apis.rb
The module containing each individual API. The goal of this module/its classes is to have a minimal LOC setup for the APIs made.

#### lib/stories.rb
This wraps the JSON that we hope to return in a Rubyish OO manner for maximum separation from the business logic of the
scraping operations performed

#### lib/server.rb
This contains the server itself, a simple sinatra/rack application

## Usage
It is a simple Rack app. In order to run it, if you fancy Heroku one must simple do the following:

```BASH
$ bundle install
$ heroku create
$ git push heroku master
```
Once deployed, we have 2 main routes:

`frontpage` [GET], params: `page` : This provides the current frontpage, 25 results.

`recent` [GET], params: `page` : This provides the provided page of recent, 25 results.

## In the Wild
A slightly older version is hosted [here](https://quiet-temple-1623.herokuapp.com/) on Heroku.
Note that the `/` endpoint for random hobos and `/hobos` for a single hobo are only working locally at the moment.

## Sample
[Here](https://gist.github.com/ybur-yug/a51436526691e5a044b5) are a few gists with samples of `recent` and `frontpage`.

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


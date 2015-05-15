# Lobste.rs Unofficial API

## Example Application
You can find a Volt app hitting this api [here](https://github.com/ybur-yug/volt_task_example).

## Structure
#### scraper.rb
This is intended to incapsulate the scraper for each site being API-ified (for now, only lobste.rs but in the future reddit)

#### apis.rb
The module containing each individual API. The goal of this module/its classes is to have a minimal LOC setup for the APIs made.

#### stories.rb
This wraps the JSON that we hope to return in a Rubyish OO manner for maximum separation from the business logic of the
scraping operations performed

#### server.rb
This contains the server itself, a simple sinatra/rack application

## Usage
It is a simple Rack app. In order to run it, if you fancy Heroku one must simple do the following:

```BASH
$ bundle install
$ heroku create
$ git push heroku master
```
Once deployed, we have 3 main routes:

`frontpage` [GET], params: `page` : This provides the current frontpage, 25 results.

## In the Wild
It is hosted [here](https://quiet-temple-1623.herokuapp.com/) on Heroku.
Note that the `/` endpoint for random hobos and `/hobos` for a single hobo are only working locally at the moment.
It is also not updated to the latest commits.

## Sample
[Here](https://gist.github.com/ybur-yug/a51436526691e5a044b5) are a few gists with samples of `recent` and `frontpage`,
and here is an example of the search POST request:

```BASH
devbox% curl -X POST  "https://quiet-temple-1623.herokuapp.com/search" -d "{\"terms\":\"python ruby\", \"page\":\"2\"}"
{
    "results": [{
        "title": "Building A Ruby List Comprehension",
        "link": "https://blog.engineyard.com/2014/ruby-list-comprehension",
        "submitter": "/u/fluxusfrequency",
        "submission_dt": "2014-11-07 11:05:29 -0600"
    }, {
        "title": "Generational GC in Python and Ruby",
        "link": "http://patshaughnessy.net/2013/10/30/generational-gc-in-python-and-ruby",
        "submitter": "/u/jcs",
        "submission_dt": "2013-10-30 23:10:41 -0500"
    ... # omitted for brevity
    {
        "title": "Announcing Topaz: A New Ruby",
        "link": "http://docs.topazruby.com/en/latest/blog/announcing-topaz/",
        "submitter": "/u/jcs",
        "submission_dt": "2013-02-06 12:04:09 -0600"
    }]
}%                 
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


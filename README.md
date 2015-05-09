# Lobste.rs Unofficial API

## Usage
It is a simple Rack app. In order to run it, if you fancy Heroku one must simple do the following:

```BASH
$ bundle install
$ heroku create
$ git push heroku master
```
Once deployed, we have 3 main routes:

`frontpage` [GET] : This provides the current frontpage, 25 results

`recent`[GET]    : This gets the most recent stories from the new section, 25 results

`search` [POST], params: `terms` : This takes JSON in the form of `"{\"terms\":\"python data science\"}"`
 and returns the first 25 results.

## In the Wild
It is hosted [here](https://quiet-temple-1623.herokuapp.com/) on Heroku.

## Sample
[Here](https://gist.github.com/ybur-yug/a51436526691e5a044b5) are two gists with samples of `recent` and `frontpage`,
and here is an example of the search POST request:

```BASH
devbox% curl -X POST  "https://quiet-temple-1623.herokuapp.com/search" -d "{\"terms\":\"python ruby\"}"
{
   "results":[
      {
         "title":"Building A Ruby List Comprehension",
         "link":"https://blog.engineyard.com/2014/ruby-list-comprehension"
      },
      {
         "title":"Generational GC in Python and Ruby",
         "link":"http://patshaughnessy.net/2013/10/30/generational-gc-in-python-and-ruby"
      },
      {
         "title":"Visualizing Garbage Collection in Ruby and Python",
         "link":"http://patshaughnessy.net/2013/10/24/visualizing-garbage-collection-in-ruby-and-python"
      },
      {
         "title":"Why Python is eating other languages' lunch in scientific computing",
         "link":"http://www.r-bloggers.com/the-homogenization-of-scientific-computing-or-why-python-is-steadily-eating-other-languages-lunch/"
      },
      {
         "title":"krypt - The next level of Ruby cryptography",
         "link":"http://emboss.github.com/blog/2012/12/02/krypt-the-next-level-of-ruby-cryptography/"
      },
      {
         "title":"Tom Stuart on TDD, BDD and Ruby",
         "link":"http://www.infoq.com/interviews/tom-stuart-tdd-ruby"
      },
      {
         "title":"Exploit Information Leaks in Random Numbers from Python, Ruby and PHP",
         "link":"https://spideroak.com/blog/20121205114003-exploit-information-leaks-in-random-numbers-from-python-ruby-and-php"
      },
      {
         "title":"Avoiding Hash Lookups in a Ruby Implementation",
         "link":"http://blog.headius.com/2012/09/avoiding-hash-lookups-in-ruby.html"
      },
      {
         "title":"Ruby on Rails 4.0 Tutorial",
         "link":"http://ruby.railstutorial.org/ruby-on-rails-tutorial-book?version=4.0"
      },
      {
         "title":"Python 3 is fine",
         "link":"http://sealedabstract.com/rants/python-3-is-fine/"
      },
      {
         "title":"Why Your Python Runs Slow. Part 1: Data Structures",
         "link":"http://lukauskas.co.uk/articles/2014/02/13/why-your-python-runs-slow-part-1-data-structures/"
      },
      {
         "title":"Python is now the most popular introductory teaching language at top U.S. universities",
         "link":"http://cacm.acm.org/blogs/blog-cacm/176450-python-is-now-the-most-popular-introductory-teaching-language-at-top-us-universities/fulltext"
      },
      {
         "title":"Surprising Pieces of Python",
         "link":"http://ballingt.com/2014/03/23/surprising-python.html"
      },
      {
         "title":"Ruby in Production: Lessons Learned",
         "link":"https://medium.com/@rdsubhas/ruby-in-production-lessons-learned-36d7ab726d99"
      },
      {
         "title":"My Weird Ruby",
         "link":"http://awardwinningfjords.com/2015/03/03/my-weird-ruby.html"
      },
      {
         "title":"Life Beyond Rails 2: A Second Look at Alternate Web Frameworks for Ruby",
         "link":"https://blog.engineyard.com/2015/life-beyond-rails-2-second-look-alternate-web-frameworks-ruby"
      },
      {
         "title":"Using PostgreSQL and jsonb with Ruby on Rails",
         "link":"http://nandovieira.com/using-postgresql-and-jsonb-with-ruby-on-rails"
      },
      {
         "title":"How to Implement a Type Checker in Python 3",
         "link":"http://www.enotagain.com/essays/how-to-implement-a-type-checker-in-python-3.html"
      },
      {
         "title":"An Online Curriculum to learn Web Development using Python and Django",
         "link":"http://www.mysliderule.com/learning-paths/web-development-python-django/"
      },
      {
         "title":"Announcing Topaz: A New Ruby",
         "link":"http://docs.topazruby.com/en/latest/blog/announcing-topaz/"
      }
   ]
}%                 
```
## Todos
- Better response codes + routing/error handling
- Allow pagination for recent, frontpage, and search
- Utilize Mechanize's cookie jar to get the cookie that can filter displayed stories
- Allow further customization of search
- View comments
- Allow user login and profile updating
- Allow invitations of other users once logged in
- Mock tests with VCR or webmock (simpler alternative)
- (and much more)

## Contributing
1. Fork, and make a branch
2. Code!
3. Test!
4. PR!


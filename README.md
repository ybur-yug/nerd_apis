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

## Todos
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


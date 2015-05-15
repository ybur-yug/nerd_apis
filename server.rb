require 'sinatra'
require 'json'
require 'hobos'

require_relative './lib/apis'

api = Apis::Lobsters.new
hobo_api = Hobos::Api.new

set :server, 'webrick'

get '/' do
  { hobos: Array.new(rand(100)) { hobo_api.hobo } }.to_json
end

get '/hobo' do
  { hobo: hobo_api.hobo.to_s }.to_json
end

get '/frontpage/:page' do
  api.frontpage(params['page'])
end

get '/recent/:page' do
  api.recent(params['page'])
end

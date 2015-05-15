require 'sinatra'
require 'json'
require 'hobos'

require_relative './lib/apis'

lobsters_api = Apis::Lobsters.new
proggit_api  = Apis::Proggit.new
hobo_api     = Hobos::Api.new

set :server, 'webrick'

get '/' do
  { hobos: Array.new(rand(100)) { hobo_api.hobo } }.to_json
end

get '/hobo' do
  { hobo: hobo_api.hobo.to_s }.to_json
end

get '/lobsters/frontpage/:page' do
  lobsters_api.frontpage(params['page'])
end

get 'lobsters/recent/:page' do
  lobsters_api.recent(params['page'])
end

get '/reddit' do
  proggit_api.frontpage
end

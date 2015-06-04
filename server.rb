require 'sinatra'
require 'json'
require 'hobos'

require_relative './lib/apis'

lobsters_api = Apis::Lobsters.new
datatau_api  = Apis::DataTau.new
proggit_api  = Apis::Proggit.new
reddit_api = Apis::Reddit.new
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

get '/proggit' do
  proggit_api.frontpage
end

get '/reddit' do
  reddit_api.frontpage
end

get '/datatau' do
  datatau_api.frontpage
end

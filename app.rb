require 'sinatra'
require_relative 'sharecast'
require 'json'

get '/' do
  erb :index
end

post '/upload' do
  a = Sharecast.parse_opml(params["opml_file"][:tempfile].read)
  erb :show, locals: { data: a.to_json}
end

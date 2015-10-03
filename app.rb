require 'sinatra'
require 'json'
require 'redis'
require 'tilt/erb'
require 'digest/md5'
require_relative 'sharecast'

get '/' do
  erb :index
end

post '/upload' do
  file = params["opml_file"][:tempfile].read
  id = Digest::MD5.hexdigest(file)

	if redis.exists(id)
		redirect to("/#{id}")
		return
	end

  podcasts = Sharecast.parse_opml(file).to_json
  redis.set(id , podcasts)
  redirect to("/#{id}")
end

get '/:id' do |id|
  data = redis.get(id)
  if data && data != []
    erb :show, locals: { data: data }
  else
    erb :not_found, locals: { id: id }
  end

end

private

def redis
  if ENV['REDISCLOUD_URL']
    @redis ||= Redis.new(url: ENV['REDISCLOUD_URL'])
  else
    @redis ||= Redis.new
  end
end

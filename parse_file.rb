require 'json'
require_relative 'sharecast'

data = Sharecast.parse_opml(File.read(ARGV[0]))

File.write("raw.json", data.to_json)

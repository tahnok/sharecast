require 'rexml/document'
require 'http'

module Sharecast

  def self.get_image(url)
    raw = HTTP.get(url).body.to_s
    doc = REXML::Document.new(raw)
    doc.elements.each("rss/channel/itunes:image") do |item|
      return item.attributes["href"]
    end
  end

  def self.parse_opml(raw_string)
    doc = REXML::Document.new(raw_string)

    podcasts = []

    doc.elements.each("opml/body/outline/outline") do |podcast|
      attrs = podcast.attributes
      url = attrs["xmlUrl"]
      image = self.get_image(url)
      data = {
        title: attrs["text"],
        url:  url,
        image_url: image,
      }
      podcasts << data
    end

    return podcasts
  end
end

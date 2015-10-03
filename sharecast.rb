require 'rexml/document'
require 'faraday_middleware'

module Sharecast

  def self.get_image(url)
    raw = self.get(url)
    doc = REXML::Document.new(raw)
    doc.elements.each("rss/channel/itunes:image") do |item|
      puts item.attributes
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

  private

  def self.get(url)
    @adapter ||= Faraday.new { |b|
      b.use FaradayMiddleware::FollowRedirects
      b.adapter :net_http
    }
    @adapter.get(url).body
  end

end

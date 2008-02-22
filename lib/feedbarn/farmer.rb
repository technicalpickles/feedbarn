require 'rubygems'
require 'feed-normalizer'
require 'open-uri'
require 'yaml'

module FeedBarn
  class Farmer
    CONFIG = 'config/feeds.yaml'
    
    attr_accessor :feeds, :config
    
    def initialize()
      self.config = YAML.load_file('config/feeds.yaml')
    end
    
    def feed_urls
      self.config['feeds'].collect { |feed|
        feed['url']
      }
    end
    
    def gather
      self.feeds = []

      self.config['feeds'].each do |feed_config|
        url = feed_config['url']
        downloaded_feed = FeedNormalizer::FeedNormalizer.parse(open(url))
        feeds << Feed.new(downloaded_feed, feed_config)
      end
       
      self.feeds
    end
  end
end
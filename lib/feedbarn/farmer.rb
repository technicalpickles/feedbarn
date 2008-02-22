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

      feed_urls.each do |url|
        self.feeds << FeedNormalizer::FeedNormalizer.parse(open(url))
      end
       
      self.feeds
    end
  end
end
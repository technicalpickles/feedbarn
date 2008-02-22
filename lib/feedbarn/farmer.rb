require 'rubygems'
require 'feed-normalizer'
require 'open-uri'
require 'yaml'

module FeedBarn
  # The gatherer of feeds, builder of barns
  class Farmer
    CONFIG = 'config/feeds.yaml'
    
    attr_accessor :config, :barns
    
    def initialize()
      self.config = YAML.load_file('config/settings.yml')
      self.barns = {}
    end
    
    def feed_urls
      self.config['feeds'].collect { |feed|
        feed['url']
      }
    end
    
    def build barn_name
      barn_config = load_config_for barn_name
      barns[barn_config['title']] = Barn.new(barn_name, barn_config)
    end
    
    def fill barn
      barn.feeds = []

      load_config_for(barn.name)['feeds'].each do |feed_config|
        url = feed_config['url']
        downloaded_feed = FeedNormalizer::FeedNormalizer.parse(open(url))
        barn.feeds << Feed.new(downloaded_feed, feed_config)
      end
       
      barn.feeds
    end
    
    def prepare_showcase barn
      FeedBarn::Showcase.new(barn)
    end
    
    private
    def load_config_for barn_name
      YAML.load_file("config/#{barn_name}.yml")
    end
  end
end
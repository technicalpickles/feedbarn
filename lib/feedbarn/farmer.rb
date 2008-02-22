require 'rubygems'
require 'feed-normalizer'
require 'open-uri'
require 'yaml'

module FeedBarn
  # The gatherer of feeds, builder of barns
  class Farmer
    CONFIG = 'config/feeds.yaml'
    
    attr_accessor :config, :barns, :blueprints
    
    def initialize()
      self.config = YAML.load_file('config/settings.yml')
      self.barns = {}
      
      self.blueprints = {}
      Dir.glob('config/barns/*.yml').each do |config_path|
        barn_name = yank_barn_name_from config_path
        self.blueprints[barn_name] = load_blueprint_from config_path
      end
    end
    
    # Builds out a barn
    def build barn_name
      blueprint = blueprints[barn_name]
      barns[blueprint['title']] = Barn.new(barn_name, blueprint)
    end
    
    # Populates a barn with feeds
    def fill barn
      barn.feeds = []

      blueprints[barn.name]['feeds'].each do |feed_config|
        url = feed_config['url']
        downloaded_feed = FeedNormalizer::FeedNormalizer.parse(open(url))
        barn.feeds << Feed.new(downloaded_feed, feed_config)
      end
       
      barn.feeds
    end
    
    # Gets a showcase ready
    def prepare_showcase barn
      FeedBarn::Showcase.new(barn)
    end
    
    private
    
    # Loads a config a particular barn
    def load_blueprint_from barn_yml
      YAML.load_file(barn_yml)
    end
    
    def yank_barn_name_from filename
      File.basename(filename).gsub(/\.yml$/,'')
    end
  end
end
module FeedBarn
  class Barn
    attr_accessor :name, :feeds
    
    def initialize(name, feeds)
      self.name = name
      self.feeds = feeds
    end
  end
end
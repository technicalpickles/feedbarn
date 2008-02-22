module FeedBarn
  class Feed
    
    def initialize(origin_feed, properties)
      @feed = origin_feed
      @properties = properties
    end
    
    def title
      @properties['title'] || @feed.title
    end
    
    def url
      @properties['url'] || @feed.url
    end
    
    def entries
      @feed.entries
    end
  end
end
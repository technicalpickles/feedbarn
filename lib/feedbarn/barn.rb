module FeedBarn
  class Barn
    attr_accessor :name, :feeds
    
    def initialize(name, feeds)
      self.name = name
      self.feeds = feeds
    end
    
    def entries
      if @entries.nil?
        collect_entries!
        sort_entries!
      end
      @entries
    end
    
    private
    
    def sort_entries!
      @entries.sort! do |a, b|
        unless a.date_published.nil? or b.date_published.nil?
          a.date_published <=> b.date_published
        else
          a.title <=> b.title
        end
      end
    end
    
    def collect_entries!
      @entries = []
      feeds.each do |feed|
        @entries += feed.entries
      end
    end
  end
end
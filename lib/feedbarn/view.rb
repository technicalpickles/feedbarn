require 'erubis'

module FeedBarn
  class View
    attr_accessor :barn
    
    def initialize(barn)
      self.barn = barn
    end
    
    def render
      input = File.read('view/default.html.erb')
      
      eruby = Erubis::Eruby.new(input)
      
      eruby.result(binding)
    end
  end
end
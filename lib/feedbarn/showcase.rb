require 'erubis'

module FeedBarn
  class Showcase
    attr_accessor :barn
    
    def initialize(barn)
      self.barn = barn
    end
    
    def render
      input = File.read('view/default.html.erb')
      
      eruby = Erubis::Eruby.new(input)
      
      eruby.result(binding)
    end
    
    def output
      Dir.mkdir(output_dir) unless File.exists?(output_dir)
      open("#{output_dir}/index.html", 'w') do |file|
        file.write render
        file.close
      end
    end
    
    def output_dir
      "output/#{self.barn.name}"
    end
  end
end
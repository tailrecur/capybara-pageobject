require 'active_support'

class Website
  extend ActiveSupport::Memoizable
  
  attr_reader :current_page
    
  def initialize page
    @page = page
    @pages_data = YAML.load_file(File.dirname(__FILE__) + '/pages.yml')
    
    @pages_data.each do |page, page_data|
      page_class = (page_data["class"] || "Page").constantize
      self.class.send(:define_method, page) do
        page_class.new(@page, page_data)
      end
      
      class_eval { memoize page }
    end
  end
  
  def visit page
    @current_page = self.send(page)
    @current_page.visit
  end
end
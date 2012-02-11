module Capybara
  module PageObject
    class Website

      def initialize page
        @page = page
        @pages_data = YAML.load_file('pages/pages.yml')

        @pages_data.each do |page, page_data|
          page_class = (page_data["class"] || "Capybara::PageObject::Page").constantize
          unless page_class.ancestors.include?(Capybara::PageObject::Page)
            raise "Custom page class '#{page_class}' should extend Capybara::PageObject::Page"
          end
          wrapper = lambda { |&page_actions| on_page_perform(page_actions) { page_class.new(@page, page_data.merge("name" => page)) } }
          self.class.send(:define_method, page, wrapper)
        end
      end

      private

      def on_page_perform(page_actions)
        page = yield
        page_actions ? page.instance_eval(&page_actions) : page
      end
    end
  end
end
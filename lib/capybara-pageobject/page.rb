module Capybara
  module PageObject
    class Page
      def initialize page, page_data
        @page = page
        @page_data = page_data
        !page_data["attributes"].nil? and page_data["attributes"].each do |attribute, selector|
          self.class.send(:define_method, attribute) do |value=nil|
            Capybara::PageObject::Attribute.new(page, attribute, selector).tap { |node| node.set(value) if value }
          end
        end

        !page_data["actions"].nil? and page_data["actions"].each do |attribute, selector|
          self.class.send(:define_method, attribute) { Action.new(page, attribute, selector) }
        end
      end

      def visit
        @page_data["url"] ? page.visit(@page_data["url"]) : raise("url not defined for page")
      end

      def visible?
        if @page_data["id"]
          begin
            page.find(@page_data["id"]).visible?
          rescue Capybara::ElementNotFound
            false
          end
        else
          raise("id not defined for page")
        end
      end

      def page_title
        page.find("head title").text
      end

      def method_missing method, *args
        page.respond_to?(method) ? page.send(method, args) : super
      end

      protected

      def to_s
        @page_data[:name]
      end

      def page
        @page
      end
    end
  end
end
require File.expand_path(File.dirname(__FILE__) + "/attribute")
require File.expand_path(File.dirname(__FILE__) + "/action")

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
        page.visit(@page_data["url"])
      end

      def visible?
        page.find(@page_data["id"]).visible?
      end

      def have_invisible(attribute)
        page.has_no_selector?(selector_for(attribute))
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
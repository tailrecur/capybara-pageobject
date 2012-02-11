module Capybara
  module PageObject
    class Page
      include CapybaraHelper

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
        @page_data["id"] ? if_absent(false) { page.find(@page_data["id"]).visible? } : raise("id not defined for page")
      end

      def page_title
        if_absent("") { page.find("head title").text }
      end

      def to_s
        "'page: #{@page_data["name"]}'"
      end

      def method_missing method, *args
        page.respond_to?(method) ? page.send(method, *args) : super
      end

      protected

      def page
        @page
      end
    end
  end
end
require 'capybara/rspec/matchers'

module Capybara
  module PageObject
    class Page
      include CapybaraHelper
      include RSpec::Matchers
      include Capybara::RSpecMatchers

      attr_accessor :context

      def initialize page, page_data
        @page = page
        @page_data = page_data
        page_data["attributes"].present? and page_data["attributes"].each do |attribute, selector|
          self.class.send(:define_method, attribute) do |value=nil|
            Capybara::PageObject::Attribute.new(page, attribute, selector).tap { |node| node.set(value) if value }
          end
        end

        page_data["actions"].present? and page_data["actions"].each do |attribute, selector|
          self.class.send(:define_method, attribute) { Action.new(page, attribute, selector) }
        end
      end

      def visit url_params={}
        page.visit(UrlParser.new(@page_data["url"]).format(url_params))
      end

      def visible?
        @page_data["id"] ? if_absent(false) { page.find(@page_data["id"]).visible? } : raise("id not defined for page")
      end

      def has_content? content
        page.has_content?(content.to_s)
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
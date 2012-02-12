require "capybara-pageobject/version"
require "monkey-patch/string"
require "monkey-patch/object"

module Capybara
  module PageObject
    autoload :Page, 'capybara-pageobject/page'
    autoload :CapybaraHelper, 'capybara-pageobject/capybara_helper'
    autoload :Element, 'capybara-pageobject/element'
    autoload :Attribute, 'capybara-pageobject/attribute'
    autoload :Action, 'capybara-pageobject/action'
    autoload :Website, 'capybara-pageobject/website'

    class << self
      def configure
        yield self
      end

      def page_file= file
        @page_file = file
      end

      def current_website
        @website ||= instantiate_website Capybara::PageObject::Website
      end

      def website_class= klass
        raise "website class #{klass} should extend Capybara::PageObject::Website" unless klass.ancestors.include?(Capybara::PageObject::Website)
        @website = instantiate_website klass
      end
    end

    private

    def self.instantiate_website klass
      klass.new(Capybara.current_session, @page_file)
    end

    module IncludedMethods
      def website
        Capybara::PageObject.current_website
      end
    end
  end
end

include Capybara::PageObject::IncludedMethods

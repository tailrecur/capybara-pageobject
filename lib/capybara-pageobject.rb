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

      def pages_file file
        @pages_file = file
      end

      def current_website
        @website ||= Capybara::PageObject::Website.new(page, @pages_file)
      end
    end

    module IncludedMethods
      def website
        Capybara::PageObject.current_website
      end
    end

    def included(base)
      base.send(:include, Capybara::PageObject::IncludedMethods)
    end
  end
end

module Capybara
  module PageObject
    class Element
      extend Forwardable
      include CapybaraHelper

      def initialize page, name, selector
        @page = page
        @name = name
        @selector = selector
      end

      def visible?
        if_absent(false) { element.visible? }
      end

      protected

      def element
        @page.find(@selector)
      end
    end
  end
end
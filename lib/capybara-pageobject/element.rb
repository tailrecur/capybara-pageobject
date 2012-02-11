module Capybara
  module PageObject
    class Element
      extend Forwardable

      def initialize page, name, selector
        @page = page
        @name = name
        @selector = selector
      end

      def visible?
        element.visible? rescue false
      end

      def to_s
        @name
      end

      protected

      def element
        @page.find(@selector)
      end
    end
  end
end
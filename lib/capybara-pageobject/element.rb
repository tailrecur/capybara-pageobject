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
        begin
          element.visible?
        rescue Capybara::ElementNotFound
          false
        end
      end


      protected

      def element
        @page.find(@selector)
      end
    end
  end
end
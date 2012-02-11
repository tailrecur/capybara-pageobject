require File.dirname(__FILE__) + '/element'

module Capybara
  module PageObject
    class Action < Element
      def_delegators :element, :click

      def disabled?
        element[:disabled]
      end
    end
  end
end

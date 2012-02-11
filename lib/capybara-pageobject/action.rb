module Capybara
  module PageObject
    class Action < Element
      def_delegators :element, :click

      def disabled?
        element[:disabled]
      end

      def to_s
        "'action: #{@name}'"
      end
    end
  end
end

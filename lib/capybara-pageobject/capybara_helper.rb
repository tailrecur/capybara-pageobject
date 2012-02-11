module Capybara
  module PageObject
    module CapybaraHelper
      private

      def if_absent(default)
        begin
          yield
        rescue Capybara::ElementNotFound
          default
        end
      end
    end
  end
end
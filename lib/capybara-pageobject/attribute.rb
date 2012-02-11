require File.dirname(__FILE__) + '/element'

module Capybara
  module PageObject
    class Attribute < Element
      def_delegators :element_value, :blank?, :==, :include?

      def set value
        element.set(value)
      end

      def validation_error
        error_field = @page.all(".field_with_errors").find do |error_field|
          Capybara.using_wait_time(0) { error_field.has_selector?(@selector) }
        end
        error_field.find(".error_message").text if error_field
      end

      def to_s
        element_value
      end

      private

      def element_value
        element.tag_name == "input" ? element.value : element.text
      end
    end
  end
end
require 'capybara/dsl'

module Capybara
  module PageObject
    class Attribute < Element
      include Capybara::DSL

      def_delegators :element_value, :blank?, :==, :include?, :to_s
      def_delegators :element, :set

      def validation_error
        error_field = @page.all(".field_with_errors").find do |error_field|
          Capybara.using_wait_time(0) { error_field.has_selector?(@selector) }
        end
        error_field.find(".error_message").text if error_field
      end

      private

      def element_value
        element.tag_name == "input" ? element.value : element.text
      end
    end
  end
end
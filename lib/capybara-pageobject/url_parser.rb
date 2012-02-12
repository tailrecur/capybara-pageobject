module Capybara
  module PageObject
    class UrlParser

      def initialize url
        raise 'url is not defined' if url.blank?
        @url = url
      end

      def format url_params
        url_params.symbolize_keys!
        dynamic_params = parse_params(@url)

        raise "Please pass url parameters: #{dynamic_params}" unless url_params.keys.sort == dynamic_params.sort
        url_params.each_pair { |param, value| @url.gsub!(":#{param}", value.to_s) }
        @url
      end

      private

      def parse_params url
        url.scan(/:(\w+)/).flatten.map { |p| p.to_sym }
      end
    end
  end
end
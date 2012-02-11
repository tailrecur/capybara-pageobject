$:.unshift(File.expand_path('../lib', File.dirname(__FILE__)))
require File.expand_path(File.dirname(__FILE__) + "/support/test_website")
require File.expand_path(File.dirname(__FILE__) + "/support/matchers/delegate")

require 'rubygems'
require "bundler/setup"
require 'rspec'
require 'capybara'
require "mocha"

RSpec.configure do |config|
  config.mock_with :mocha

  config.before(:each) do
    @capybara_page = Capybara::Session.new(:schmoo, TestWebsite)
  end
end

def capybara_page
  @capybara_page
end

Capybara.register_driver :schmoo do |app|
  Capybara::RackTest::Driver.new(app)
end

require 'capybara-pageobject'

alias :running :lambda

Capybara.default_wait_time = 0 # less timeout so tests run faster


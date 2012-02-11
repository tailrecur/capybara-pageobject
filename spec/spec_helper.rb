$:.unshift(File.expand_path('../lib', File.dirname(__FILE__)))
require File.expand_path(File.dirname(__FILE__) + "/support/test_website")

require 'rubygems'
require "bundler/setup"
require 'rspec'
require 'capybara'
require "mocha"

RSpec.configure do |config|
  config.mock_with :mocha
end

require 'capybara-pageobject'

alias :running :lambda

Capybara.default_wait_time = 0 # less timeout so tests run faster


require 'rubygems'
require "bundler/gem_tasks"
require 'rspec/core/rake_task'

desc "Run all unit tests"
RSpec::Core::RakeTask.new(:spec) do |t|
  t.rspec_opts = %w[--color]
end

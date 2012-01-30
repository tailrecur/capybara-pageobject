# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "capybara-pageobject/version"

Gem::Specification.new do |s|
  s.name        = "capybara-pageobject"
  s.version     = Capybara::Pageobject::VERSION
  s.authors     = ["dlewis"]
  s.email       = ["deepak.lewis@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Easily create page objects to abstract UI Pages}
  s.description = %q{This gem makes it very simple to introduce page objects to your capybara-based functional tests}

  s.rubyforge_project = "capybara-pageobject"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  s.add_runtime_dependency("capybara", [">= 1.0.0"])
end

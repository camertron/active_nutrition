# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "version"

Gem::Specification.new do |s|
  s.name        = "active_nutrition"
  s.version     = ActiveNutrition::VERSION
  s.authors     = ["Cameron Dutro"]
  s.email       = ["camertron@gmail.com"]
  s.homepage    = "http://github.com/camertron"
  s.summary     = "USDA nutrition data"
  s.description = "Updates, maintains, and provides systematic access to USDA nutrition data.  See lib/examples to get started."

  s.rubyforge_project = "active_nutrition"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"

  s.add_runtime_dependency "activerecord", "~> 3.1.0"
  s.add_runtime_dependency "rubyzip", "~> 0.9.4"
  s.add_runtime_dependency "activerecord-import", "~> 0.2.8"
  s.add_runtime_dependency "composite_primary_keys", "~> 4.1.1"
end

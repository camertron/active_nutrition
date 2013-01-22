# encoding: UTF-8

$:.push File.expand_path("../lib/active_nutrition", __FILE__)
require "version"

Gem::Specification.new do |s|
  s.name        = "active_nutrition"
  s.version     = ActiveNutrition::VERSION
  s.authors     = ["Cameron Dutro"]
  s.email       = ["camertron@gmail.com"]
  s.homepage    = "http://github.com/camertron"
  s.summary     = "USDA nutrition data"
  s.description = "An ActiveRecord-backed collection of models for storing and retrieving nutritional information from the USDA's Nutrient Database."

  s.rubyforge_project = "active_nutrition"

  s.files         = Dir["lib/**/*"]
  s.test_files    = Dir["spec/**/*"]
  s.require_paths = ["lib"]

  s.add_runtime_dependency "activerecord", "~> 3.0"
  s.add_runtime_dependency "rubyzip", "~> 0.9.4"
  s.add_runtime_dependency "composite_primary_keys", "~> 5.0.12"
end

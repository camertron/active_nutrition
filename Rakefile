require "bundler/gem_tasks"
require File.join(File.dirname(__FILE__), "lib/version")

task :gem do
  unless File.directory?("pkg")
    Dir.mkdir("pkg")
  end

  `gem build active_nutrition.gemspec`
  `mv active_nutrition-#{ActiveNutrition::VERSION}.gem pkg`
end
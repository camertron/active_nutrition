require "bundler/gem_tasks"

task :gem do
  unless File.directory?("pkg")
    Dir.mkdir("pkg")
  end

  `cd pkg && gem build ../active_nutrition.gemspec`
end
# encoding: UTF-8

include Rake::DSL

module ActiveNutrition
  class Railtie < Rails::Railtie
    rake_tasks do
      namespace :active_nutrition do
        task :migrate => :environment do
          ActiveNutrition.migrate
        end

        task :update => :environment do
          raise "Not yet supported."
        end

        task :rebuild, [:encoding, :models] => [:environment] do |t, args|
          args.with_defaults(:encoding => "UTF-8", :models => "All")
          ActiveNutrition.rebuild(args[:encoding], args[:models].split(" ").map(&:to_s))
        end
      end

      namespace :an do
        task :migrate => "active_nutrition:migrate"
        task :update => "active_nutrition:update"
        task :rebuild => "active_nutrition:rebuild"
      end
    end
  end
end
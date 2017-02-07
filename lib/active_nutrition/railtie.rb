# encoding: UTF-8

include Rake::DSL

module ActiveNutrition
  class Railtie < Rails::Railtie
    generators do
      require 'active_nutrition/install_generator'
    end

    rake_tasks do
      namespace :active_nutrition do
        task rebuild: :environment do
          ActiveNutrition.rebuild
        end
      end

      namespace :an do
        task rebuild: 'active_nutrition:rebuild'
      end
    end
  end
end

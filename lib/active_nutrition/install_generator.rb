require 'rails/generators'
require 'rails/generators/migration'
require 'rails/generators/active_record'

module ActiveNutrition
  class InstallGenerator < ::Rails::Generators::Base
    include ::ActiveRecord::Generators::Migration

    source_root File.expand_path('../migrations', __FILE__)
    desc 'Generate ActiveNutrition migrations'

    def create_model_file
      migration_template 'create_active_nutrition_sr_24.rb', 'db/migrate/create_active_nutrition_sr_24.rb'
    end
  end
end

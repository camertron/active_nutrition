$:.unshift(File.dirname(__FILE__)) unless $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require "active_record"
require 'activerecord-import'
require "json"

# base object for retrieving nutrition info, plus a few other handy files
require "nutrition"
require "models/active_nutrition_migration"
require "migrations/00000000001_migrations_table"

# require all object wrappers (base first)
require "objects/base"
require "objects/food"
require "objects/food_group"
require "objects/nutrition_fact"

# require all the retriever stuff (for downloading seed data and updates)
require "manage/usda/usda_parser"
require "manage/usda/usda_updater"

# require rake tasks
#require "tasks/active_nutrition.rake"

module ActiveNutrition
  @@database_config = {}
  @@migrations = []

  def self.database_config
    @@database_config
  end

  def self.configure(options)
    @@database_config = options[:database_config]

    # require all models, list all migrations
    self.require_dir(File.join(File.dirname(__FILE__), "models"))
    @@migrations = Dir.glob(File.join(File.dirname(__FILE__), "migrations/**/**"))

    ActiveNutrition.establish_connection
  end

  def self.establish_connection
    ActiveRecord::Base.establish_connection(ActiveNutrition.database_config)
  end

  def self.migrate
    current_migrations = ActiveNutritionMigration.find(:all).map(&:sequence_no)
  rescue ActiveRecord::StatementInvalid => e
    ActiveNutrition::MigrationsTable.up
    ActiveNutritionMigration.create(:sequence_no => 1)
    current_migrations = ActiveNutritionMigration.find(:all).map(&:sequence_no)
  ensure
    next_migrations = @@migrations.reject { |file| current_migrations.include?(File.basename(file)[0..11].to_i) }.sort
    next_migrations.each do |file|
      require file
      migration_class = ActiveNutrition.const_get(File.basename(file).split("_")[1..-1].map(&:capitalize).join("").chomp(".rb"))
      migration_class.up
      ActiveNutritionMigration.create(:sequence_no => File.basename(file)[0..11].to_i)
    end
  end

  def self.update
    upd = ActiveNutrition::USDAUpdater.new(:type => :update)
    upd.reset_db
    execute_update(upd)
  end

  def self.rebuild
    upd = ActiveNutrition::USDAUpdater.new(:type => :full)
    upd.reset_db
    execute_update(upd)
  end

  protected

  def self.execute_update(updater)
    print "\r\n"
    updater.execute do |model, record_count, record_total|
      print "\rProcessing #{model}, #{record_count} / #{record_total} (#{((record_count.to_f / record_total.to_f) * 100).round}%) records imported"
      STDOUT.flush
    end
  end

  def self.require_dir(dir)
    Dir.glob(File.join("#{dir}", "*.rb")).each do |rb_file|
      require rb_file
    end
  end
end
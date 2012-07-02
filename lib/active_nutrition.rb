# encoding: UTF-8

$:.push(File.dirname(__FILE__))
$:.push(File.dirname(File.dirname(__FILE__)))

$KCODE = 'UTF-8' unless RUBY_VERSION >= '1.9.0'

require 'json'
require 'open-uri'
require 'fileutils'
require 'zip/zip'
require 'yaml'
require 'rake'

require 'active_record'
require 'composite_primary_keys'

require 'models'
require 'objects'
require 'utilities'
require 'migrations/00000000001_migrations_table'

require 'railtie'

include ActiveNutrition::Models
include ActiveNutrition::Objects
include ActiveNutrition::Utilities

module ActiveNutrition
  DEFAULT_SEARCH_LIMIT = 10

  class << self
    def migrate
      current_migrations = Migration.find(:all).map(&:sequence_no)
    rescue ActiveRecord::StatementInvalid => e
      ActiveNutrition::Migrations::MigrationsTable.up
      Migration.create(:sequence_no => 1)
      current_migrations = Migration.find(:all).map(&:sequence_no)
    ensure
      next_migrations = migrations.reject { |file| (current_migrations || []).include?(File.basename(file)[0..11].to_i) }.sort
      next_migrations.each do |file|
        require file
        migration_class = ActiveNutrition::Migrations.const_get(File.basename(file).split("_")[1..-1].map(&:capitalize).join("").chomp(".rb"))
        migration_class.up
        Migration.create(:sequence_no => File.basename(file)[0..11].to_i)
      end
    end

    def update
      upd = Update.new(:type => :update)
      upd.clean
      upd.download
      upd.unzip
      execute_update(upd)
    end

    def rebuild
      upd = Update.new(:type => :full)
      upd.clean
      upd.download
      upd.unzip
      upd.reset_db
      execute_update(upd)
    end

    def search(terms = "", options = {})
      options[:conditions] ||= ["Long_Desc LIKE ? OR Long_Desc LIKE ?", "%#{terms.gsub(" ", "%")}%", "%#{terms.split(" ").reverse.join("%")}%"]
      options[:limit] ||= DEFAULT_SEARCH_LIMIT
      Food.wrap(FoodDes.find(:all, options))
    end

    def get(ndb_no)
      Food.wrap(FoodDes.find(ndb_no))
    end

    def convert(value, options = {})
      UnitConverter.convert(value, options)
    end

    def supported_conversion?(options)
      UnitConverter.supported_conversion?(options)
    end

    protected

    def migrations
      @migrations ||= Dir.glob(File.join(File.dirname(__FILE__), "active_nutrition/migrations/**/**.rb"))
    end

    def execute_update(updater)
      last_model = nil
      updater.execute do |model, record_count, record_total|
        puts "" unless model == last_model
        print "\rProcessing #{model}, #{record_count} / #{record_total} (#{((record_count.to_f / record_total.to_f) * 100).round}%) records imported"
        STDOUT.flush
        last_model = model
      end
    end
  end
end
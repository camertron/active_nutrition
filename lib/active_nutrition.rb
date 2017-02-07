# encoding: UTF-8

require 'rake'
require 'active_record'
require 'composite_primary_keys'
require 'active_nutrition/railtie' if defined?(Rails)

module ActiveNutrition
  autoload :Models,    'active_nutrition/models'
  autoload :Objects,   'active_nutrition/objects'
  autoload :Utilities, 'active_nutrition/utilities'

  class << self
    DEFAULT_SEARCH_LIMIT = 10

    include Models
    include Objects

    def rebuild
      upd = Utilities::Update.new(type: :full)
      puts 'Downloading data...'
      upd.download
      puts 'Extracting...'
      upd.unzip
      puts 'Clearing tables...'
      upd.reset_db
      execute_update(upd)
      puts "\nDone."
    end

    def search(terms = '', options = {})
      match_conditions = [
        "%#{terms.gsub(' ', '%')}%",
        "%#{terms.split(' ').reverse.join('%')}%"
      ]

      query = match_conditions.uniq.inject(nil) do |ret, condition|
        match = FoodDes.arel_table[:Long_Desc].matches(condition)
        next ret.or(match) if ret
        match
      end

      limit = options.fetch(:limit, DEFAULT_SEARCH_LIMIT)

      Food.wrap(FoodDes.where(query).limit(limit).to_a)
    end

    def get(ndb_no)
      Food.wrap(FoodDes.find(ndb_no))
    end

    def convert(value, options = {})
      Utilities::UnitConverter.convert(value, options)
    end

    def supported_conversion?(options)
      Utilities::UnitConverter.supported_conversion?(options)
    end

    private

    def execute_update(updater)
      last_model = nil
      updater.execute do |model, record_count, record_total|
        puts '' unless model == last_model
        print "\rProcessing #{model}, #{record_count} / #{record_total} (#{((record_count.to_f / record_total.to_f) * 100).round}%) records imported"
        STDOUT.flush
        last_model = model
      end
    end
  end
end

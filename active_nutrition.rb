$:.push File.expand_path("../lib", __FILE__)

require "sqlite3"
require "active_record"
require "json"

require "nutrition"

# require all object wrappers (base first)
require "objects/base"
require "objects/food"
require "objects/food_group"
require "objects/nutrition_fact"

module ActiveNutrition
  @@database = ""

  def self.database
    @@database
  end

  def self.configure(options)
    @@database = options[:database]

    # require all models
    Dir.glob("#{File.join(File.dirname(__FILE__), "lib/models")}/*.rb").each do |model_file|
      require model_file
    end
  end
end
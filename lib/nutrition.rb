module ActiveNutrition
  class Nutrition
    DEFAULT_SEARCH_LIMIT = 10

    def self.establish_connection
      ActiveRecord::Base.establish_connection(:adapter => 'sqlite3', :database => ActiveNutrition.database)
    end

    def self.search(terms = "", options = {})
      options[:conditions] = ["Long_Desc LIKE ?", "%#{terms.gsub(" ", "%")}%"] unless options[:conditions]
      options[:limit] = DEFAULT_SEARCH_LIMIT unless options[:limit]
      Food.wrap(FoodDes.find(:all, options))
    end

    def self.get(ndb_no)
      Food.wrap(FoodDes.find(ndb_no))
    end
  end
end
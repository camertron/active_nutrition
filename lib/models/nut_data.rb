module ActiveNutrition
  class NutData < ActiveRecord::Base
    ActiveNutrition::Nutrition.establish_connection

    set_table_name "nut_data"
    set_primary_key :NDB_No

    alias_attribute :value, :Nutr_Val

    belongs_to :definition, :class_name => "NutrDef", :foreign_key => "Nutr_No", :primary_key => "Nutr_No"

    # the value of Nutr_Val is the number of grams in 100 grams total,
    # which it makes it easy to calculate the amount in every 1 gram
    def amount_per_gram
      return self.Nutr_Val.to_f / 100.0
    end
  end
end
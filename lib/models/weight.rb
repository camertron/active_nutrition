module ActiveNutrition
  class Weight < ActiveRecord::Base
    ActiveNutrition::Nutrition.establish_connection

    set_table_name "weight"
    set_primary_key :NDB_No

    alias_attribute :amount, :Amount
    alias_attribute :grams, :Gm_Wgt
    alias_attribute :measurement, :Msre_Desc
  end
end
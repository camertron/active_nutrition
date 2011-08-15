module ActiveNutrition
  class NutrDef < ActiveRecord::Base
    ActiveNutrition::Nutrition.establish_connection

    set_table_name "nutr_def"
    set_primary_key :Nutr_No

    alias_attribute :units, :Units
    alias_attribute :name, :NutrDesc
    alias_attribute :tag_name, :Tagname
  end
end
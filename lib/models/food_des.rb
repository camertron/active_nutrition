module ActiveNutrition
  class FoodDes < ActiveRecord::Base
    set_table_name "food_des"
    set_primary_key :NDB_No

    alias_attribute :description, :Long_Desc
    alias_attribute :common_name, :ComName
    alias_attribute :manufacturer, :ManufacName

    has_many :nutrition_facts, :class_name => "NutData", :foreign_key => "NDB_No", :primary_key => "NDB_No"
    has_many :weights, :class_name => "Weight", :foreign_key => "NDB_No", :primary_key => "NDB_No"

    belongs_to :food_group, :class_name => "FdGroup", :foreign_key => "FdGrp_Cd", :primary_key => "FdGrp_CD"
  end
end
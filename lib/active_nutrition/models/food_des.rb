# encoding: UTF-8

module ActiveNutrition
  module Models
    class FoodDes < ActiveRecord::Base
      self.table_name = "food_des"
      self.primary_key = :NDB_No

      alias_attribute :description, :Long_Desc
      alias_attribute :common_name, :ComName
      alias_attribute :manufacturer, :ManufacName

      has_many :nutrition_facts, :class_name => "ActiveNutrition::Models::NutData", :foreign_key => "NDB_No", :primary_key => "NDB_No"
      has_many :weights, :class_name => "ActiveNutrition::Models::Weight", :foreign_key => "NDB_No", :primary_key => "NDB_No"

      belongs_to :food_group, :class_name => "ActiveNutrition::Models::FdGroup", :foreign_key => "FdGrp_Cd", :primary_key => "FdGrp_CD"
    end
  end
end
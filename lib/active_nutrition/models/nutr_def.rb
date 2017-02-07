# encoding: UTF-8

module ActiveNutrition
  module Models
    class NutrDef < ActiveRecord::Base
      self.table_name = 'nutr_def'
      self.primary_key = :Nutr_No

      alias_attribute :units, :Units
      alias_attribute :name, :NutrDesc
      alias_attribute :tag_name, :Tagname
    end
  end
end

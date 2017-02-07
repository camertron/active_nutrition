# encoding: UTF-8

module ActiveNutrition
  module Models
    class NutData < ActiveRecord::Base
      self.table_name = 'nut_data'
      self.primary_key = :NDB_No

      alias_attribute :value, :Nutr_Val

      belongs_to :definition, class_name: 'ActiveNutrition::Models::NutrDef', foreign_key: 'Nutr_No', primary_key: 'Nutr_No'
      validates :NDB_No, uniqueness: { scope: [:Nutr_No] }
      validates :Nutr_No, uniqueness: { scope: [:NDB_No] }

      # the value of Nutr_Val is the number of grams in 100 grams total,
      # which it makes it easy to calculate the amount in every 1 gram
      def amount_per_gram
        return self.Nutr_Val.to_f / 100.0
      end
    end
  end
end

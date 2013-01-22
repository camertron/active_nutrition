# encoding: UTF-8

module ActiveNutrition
  module Models
    class Weight < ActiveRecord::Base
      self.table_name = "weight"
      self.primary_key = :NDB_No

      validates :NDB_No, :uniqueness => { :scope => [:Seq] }
      validates :Seq, :uniqueness => { :scope => [:NDB_No] }

      alias_attribute :amount, :Amount
      alias_attribute :grams, :Gm_Wgt
      alias_attribute :measurement, :Msre_Desc
    end
  end
end
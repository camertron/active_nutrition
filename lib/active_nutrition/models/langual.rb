# encoding: UTF-8

module ActiveNutrition
  module Models
    class Langual < ActiveRecord::Base
      self.table_name = 'langual'
      self.primary_key = :NDB_No

      validates :NDB_No, uniqueness: { scope: [:Factor_Code] }
      validates :Factor_Code, uniqueness: { scope: [:NDB_No] }
    end
  end
end

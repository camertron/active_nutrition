# encoding: UTF-8

module ActiveNutrition
  module Models
    class Datsrcln < ActiveRecord::Base
      self.table_name = "datsrcln"
      self.primary_key = :NDB_No

      validates :NDB_No, :uniqueness => { :scope => [:Nutr_No, :DataSrc_ID] }
      validates :Nutr_No, :uniqueness => { :scope => [:NDB_No, :DataSrc_ID] }
      validates :DataSrc_ID, :uniqueness => { :scope => [:NDB_No, :Nutr_No] }
    end
  end
end
# encoding: UTF-8

module ActiveNutrition
  module Models
    class DerivCd < ActiveRecord::Base
      self.table_name = 'deriv_cd'
      self.primary_key = :Deriv_CD
    end
  end
end

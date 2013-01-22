# encoding: UTF-8

module ActiveNutrition
  module Models
    class SrcCd < ActiveRecord::Base
      self.table_name = "src_cd"
      self.primary_key = :Src_Cd
    end
  end
end
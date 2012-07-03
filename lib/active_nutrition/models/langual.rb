# encoding: UTF-8

module ActiveNutrition
  module Models
    class Langual < ActiveRecord::Base
      set_table_name "langual"
      set_primary_key :NDB_No

      validates :NDB_No, :uniqueness => { :scope => [:Factor_Code] }
      validates :Factor_Code, :uniqueness => { :scope => [:NDB_No] }
    end
  end
end
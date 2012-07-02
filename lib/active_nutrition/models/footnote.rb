# encoding: UTF-8

module ActiveNutrition
  module Models
    class Footnote < ActiveRecord::Base
      set_table_name "footnote"
      set_primary_key :Footnt_No
    end
  end
end
# encoding: UTF-8

module ActiveNutrition
  module Models
    class DataSrc < ActiveRecord::Base
      set_table_name "data_src"
      set_primary_key :DataSrc_ID
    end
  end
end
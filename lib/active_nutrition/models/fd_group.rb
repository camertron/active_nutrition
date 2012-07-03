# encoding: UTF-8

module ActiveNutrition
  module Models
    class FdGroup < ActiveRecord::Base
      set_table_name "fd_group"
      set_primary_key :FdGrp_CD
    end
  end
end
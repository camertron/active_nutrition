module ActiveNutrition
  class FdGroup < ActiveRecord::Base
    set_table_name "fd_group"
    set_primary_key :FdGrp_CD
  end
end
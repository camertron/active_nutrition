module ActiveNutrition
  class FdGroup < ActiveRecord::Base
    ActiveNutrition::Nutrition.establish_connection

    set_table_name "fd_group"
    set_primary_key :FdGrp_CD
  end
end
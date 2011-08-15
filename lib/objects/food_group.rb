module ActiveNutrition
  class FoodGroup < ActiveNutrition::Base
    METHOD_MAP = { :name => :FdGrp_Desc,
                   :code => :FdGrp_CD }

    def initialize(fd_group_model)
      @attributes = fd_group_model.attributes
    end
  end
end
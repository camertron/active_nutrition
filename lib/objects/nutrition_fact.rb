module ActiveNutrition
  class NutritionFact < ActiveNutrition::Base
    METHOD_MAP = { :nutrition_number => :Nutr_No,
                   :value => :Nutr_Val,
                   :num_data_points => :Num_Data_Pts,
                   :standard_error => :Std_Error,
                   :units => :Units,
                   :description => :Nutr_Desc,
                   :tag_name => :Tagname,
                   :sr_order => :SR_Order }

    def initialize(nut_data_model)
      @attributes = nut_data_model.attributes
      @attributes.merge!(nut_data_model.definition.attributes)
    end
  end
end
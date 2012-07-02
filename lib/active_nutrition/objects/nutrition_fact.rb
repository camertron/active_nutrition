# encoding: UTF-8

module ActiveNutrition
  module Objects
    class NutritionFact < Base
      METHOD_MAP = { :nutrition_number => :Nutr_No,
                     :value => :Nutr_Val,
                     :num_data_points => :Num_Data_Pts,
                     :standard_error => :Std_Error,
                     :units => :Units,
                     :description => :NutrDesc,
                     :tag_name => :Tagname,
                     :sr_order => :SR_Order }

      METHOD_MAP.each_pair do |method, attr_name|
        define_method(method) { self.attributes[attr_name.to_s] }
      end

      def initialize(nut_data_model)
        @attributes = nut_data_model.attributes
        @attributes.merge!(nut_data_model.definition.attributes)
      end
    end
  end
end
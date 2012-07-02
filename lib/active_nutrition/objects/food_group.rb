# encoding: UTF-8

module ActiveNutrition
  module Objects
    class FoodGroup < Base
      METHOD_MAP = { :name => :FdGrp_Desc,
                     :code => :FdGrp_CD }

      METHOD_MAP.each_pair do |method, attr_name|
        define_method(method) { self.attributes[attr_name.to_s] }
      end

      def initialize(fd_group_model)
        @attributes = fd_group_model.attributes
      end
    end
  end
end
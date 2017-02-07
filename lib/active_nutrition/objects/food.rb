# encoding: UTF-8

module ActiveNutrition
  module Objects
    class Food < Base
      METHOD_MAP = {
        name: :Long_Desc,
        ndb_number: :NDB_No,
        common_name: :ComName,
        manufacturers_name: :ManufacName,
        survey: :Survey,
        scientific_name: :SciName,
        fat_factor: :Fat_Factor,
        protein_factor: :Pro_Factor
      }

      METHOD_MAP.each_pair do |method, attr_name|
        define_method(method) { attributes[attr_name.to_s] }
      end

      attr_reader :food_group, :nutrition_facts

      def food_group
        @food_group ||= FoodGroup.new(base_model.food_group)
      end

      def nutrition_facts
        @nutrition_facts ||= NutritionFacts.new(NutritionFact.wrap(base_model.nutrition_facts.to_a))
      end

      def weights
        @weights ||= Weights.new(Weight.wrap(base_model.weights.to_a))
      end

      def factors
        [:fat_factor, :protein_factor].inject({}) do |ret, factor|
          ret[factor] = attributes[METHOD_MAP[factor].to_s]
          ret
        end
      end
    end
  end
end

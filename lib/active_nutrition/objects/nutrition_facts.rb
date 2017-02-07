# encoding: UTF-8

module ActiveNutrition
  module Objects
    class NutritionFacts < Array
      METHOD_MAP = {
        protein: 'Protein',
        carbohydrates: 'Carbohydrate, by difference',
        sugars: 'Sugars, total',
        dietary_fiber: 'Fiber, total dietary',
        cholesterol: 'Cholesterol',
        fat: 'Total lipid (fat)',
        sodium: 'Sodium, Na'
      }

      METHOD_MAP.each_pair do |method, attr_name|
        define_method(method) do
          fact = find { |fact| fact.description == attr_name }
          fact.value if fact
        end
      end

      def to_hash(options = {})
        options[:by] ||= :description
        inject({}) do |ret, fact|
          ret[fact.send(options[:by])] = fact.value
          ret
        end
      end
    end
  end
end

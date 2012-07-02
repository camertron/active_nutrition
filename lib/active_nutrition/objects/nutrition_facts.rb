# encoding: UTF-8

module ActiveNutrition
  module Objects
    class NutritionFacts < Array
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
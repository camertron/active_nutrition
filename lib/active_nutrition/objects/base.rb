# encoding: UTF-8

module ActiveNutrition
  module Objects
    class Base
      attr_reader :attributes

      def self.wrap(obj)
        if obj.is_a?(Array)
          obj.map { |o| new(o) }
        else
          new(obj)
        end
      end
    end
  end
end
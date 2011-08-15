module ActiveNutrition
  class Base
    attr_reader :attributes

    def self.wrap(obj)
      if obj.is_a?(Array)
        obj.map { |o| new(o) }
      else
        new(obj)
      end
    end

    def method_missing(m, *args)
      method_map = self.class.const_get(:METHOD_MAP)
      if method_map[m]
        @attributes[method_map[m].to_s]
      elsif @attributes[m]
        @attributes[m]
      end
    end
  end
end
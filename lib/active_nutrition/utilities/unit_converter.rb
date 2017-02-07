# encoding: UTF-8

module ActiveNutrition
  class UnsupportedConversionError < StandardError; end

  module Utilities
    class UnitConverter
      CONVERSIONS = {
        oz:     { lb: 16.0 },  # i.e. to convert from pounds to ounces, multiply by 16 (because there are 16 ounces per pound)
        lb:     { oz: 1.0 / 16.0 },
        tsp:    { tbsp: 3.0,        cup:  48.0,        pint: 96.0,      quart: 192.0,    gallon: 768.0 },
        tbsp:   { tsp: 1.0 / 3.0,   cup:  16.0,        pint: 32.0,      quart: 64.0,     gallon: 256.0 },
        cup:    { tsp: 1.0 / 48.0,  tbsp: 1.0 / 16.0,  pint: 2.0,       quart: 4.0,      gallon: 16.0 },
        pint:   { tsp: 1.0 / 96.0,  tbsp: 1.0 / 32.0,  cup: 1.0 / 2.0,  quart: 2.0,      gallon: 8.0 },
        quart:  { tsp: 1.0 / 192.0, tbsp: 1.0 / 64.0,  cup: 1.0 / 4.0,  pint: 1.0 / 2.0, gallon: 4.0 },
        gallon: { tsp: 1.0 / 768.0, tbsp: 1.0 / 256.0, cup: 1.0 / 16.0, pint: 1.0 / 8.0, quart: 1.0 / 4.0 }
      }

      class << self
        def convert(value, options = {})
          unless supported_conversion?(options)
            raise UnsupportedConversionError,
              'Conversion not supported - are you trying to convert weight to volume?'
          end

          value * CONVERSIONS[options[:to]][options[:from]]
        end

        def supported_conversion?(options = {})
          CONVERSIONS.include?(options[:to]) &&
            CONVERSIONS[options[:to]].include?(options[:from])
        end
      end
    end
  end
end

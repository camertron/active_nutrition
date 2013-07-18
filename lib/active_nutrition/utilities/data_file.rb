# encoding: UTF-8

module ActiveNutrition
  module Utilities
    class DataFile
      attr_reader :file, :handle

      FIELD_SEP = '^'
      FIELD_ENC = '~'
      NULL_FIELDS = ['^^', '~~', "\r\n", '']

      def initialize(file, enc_type)
        @file = file
        @handle = File.open(file, "r")
        @enc_type = enc_type
      end

      def each
        @handle.each do |line|
          yield self.parse_line(line)
        end
        self.clean_up
      end

      protected

      def clean_up
        @handle.close
      end

      def parse_line(line)
        if (@enc_type != "UTF-8")
          # This is the USDA file native encoding.
          line.force_encoding("ISO-8859-1")
        else
          if (!line.force_encoding("UTF-8").valid_encoding?)
            puts "\nInvalid UTF-8 char found and fixed! Before / After:\n" + line

            if @file.include?("FOOD_DES")
              line.encode!("UTF-16", :undef => :replace, :invalid => :replace, :replace => "\"")
            elsif @file.include?("NUTR_DEF")
              line.encode!("UTF-16", :undef => :replace, :invalid => :replace, :replace => "µ")
            end

            line.encode!("UTF-8")
            puts line + "\n"
          else
            line.encode!("UTF-8")
          end
        end

        #line.byte_size = 8
        line.chomp!("\r\n")
        fields = line.split('^')
        p_fields = []

        fields.each do |field|
          # strip the '~' if present
          if field.index('"')
            field.gsub!(/[\"]/, "'")
          end

          if field.index(FIELD_ENC) && field.size > 2
            p_fields << field[1..-2]
          else
            # else if the field matches a null field
            if NULL_FIELDS.include?(field)
              p_fields << ''
            elsif field.include?('.')
              # else the field must be a number
              p_fields << field.to_f
            elsif field.include?('/')
              # check to see if its a date, add as a string for now
              p_fields << field
            else
              p_fields << field.to_i  
            end
          end
        end
        p_fields
      rescue => e
        puts line
        puts e.message
        puts e.backtrace
      end
    end
  end
end
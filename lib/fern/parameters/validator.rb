require 'active_support/core_ext/module'
require 'active_support/inflector'

require 'fern/parameters/invalid'
require 'fern/parameters/errors'

module Fern
  module Parameters
    class Validator
      attr_accessor :errors
      attr_accessor :declared

      def initialize(config)
        @config = config
        @errors = Errors.new
        @declared = {}
      end

      def validate(params)
        @config.each do |name, config|
          if params.key?(name)
            @declared[name] = validate_constraints(
              name,
              params[name],
              config
            )
          else
            @declared[name] = config[:default] if config.key?(:default)
            if config[:required] && @declared[name].nil?
              @errors.add(name, 'is required')
            end
          end
        end
      end

      private

      def validate_constraints(name, raw_val, config)
        val = validate_type(name, raw_val, config[:type], config)

        return if val.nil?

        validate_numeric_constraints(name, val, config)
        validate_inclusion(name, val, config)

        val
      end

      def parse_type(val, type, array = false)
        meth = "validate_#{type}"
        if array
          parsed = val.map { |el| self.send(meth, el) }
          return nil unless parsed.all? { |el| !el.nil? } && parsed
          parsed
        else
          self.send(meth, val)
        end
      end

      def validate_boolean(val)
        if val.casecmp('true').zero?
          true
        elsif val.casecmp('false').zero?
          false
        else
          nil
        end
      end

      def validate_date(val)
        Date.parse(val)
      rescue ArgumentError
      end

      def validate_datetime(val)
        DateTime.parse(val)
      rescue ArgumentError
      end

      def validate_float(val)
        Float(val)
      rescue ArgumentError
      end

      def validate_inclusion(name, val, constraints)
        return unless constraints.key?(:values)
        return if constraints[:values].include?(val)
        @errors.add(name, "must be one of #{constraints[:values]}")
      end

      def validate_integer(val)
        Integer(val)
      rescue ArgumentError
      rescue TypeError
      end

      def validate_max(name, val, max)
        return unless val > max
        @errors.add(name, "must be less than or equal to #{max}")
      end

      def validate_min(name, val, min)
        return unless val < min
        @errors.add(name, "must be greater than or equal to #{min}")
      end

      def validate_numeric(name, val)
        validate_float(val) || @errors.add(name, 'must be a number')
      end

      def validate_numeric_constraints(name, val, constraints)
        return unless constraints.key?(:min) || constraints.key?(:max)
        validate_numeric(name, val)
        validate_min(name, val, constraints[:min]) if constraints.key?(:min)
        validate_max(name, val, constraints[:max]) if constraints.key?(:max)
      end

      def validate_string(val)
        val
      end

      def validate_type(name, val, type, config)
        parsed = parse_type(val, type, config[:constraints][:array])
        if parsed.nil?
          if config[:constraints][:array]
            @errors.add(name, "is not an array of #{pluralize(type)}")
          else
            @errors.add(name, "is not #{indefinite_articlerize(type)}")
          end
        end
        parsed
      end

      def pluralize(word)
        ActiveSupport::Inflector.pluralize(word)
      end

      def indefinite_articlerize(word)
        %w(a e i o u).include?(word[0].downcase) ? "an #{word}" : "a #{word}"
      end
    end
  end
end

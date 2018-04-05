require 'active_support/core_ext/module'
require 'active_support/core_ext/hash/indifferent_access'

require 'fern/parameters/invalid'
require 'fern/parameters/validator'

module Fern
  module Parameters
    class Parameters
      delegate :keys,
        :key?,
        :has_key?,
        :values,
        :has_value?,
        :value?,
        :empty?,
        :include?,
        :as_json,
        :[],
        :to_h,
        to: :@parameters

      def initialize(parameters, config)
        @parameters = parameters.with_indifferent_access.symbolize_keys
        @config = config.deep_symbolize_keys! unless config.nil?
      end

      def validated
        validator = Validator.new(@config)
        validator.validate(@parameters)

        if validator.errors.any?
          raise Invalid.new(validator.errors), 'invalid parameters'
        end

        self.class.new(validator.declared, @config)
      end
    end
  end
end

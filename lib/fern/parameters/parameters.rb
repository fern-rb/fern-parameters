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
        @parameters = parameters.with_indifferent_access
        @config = config.deep_symbolize_keys!
      end

      def validated
        validator = Validator.new(@config)
        validator.validate(@parameters)

        raise Invalid(validator.errors) if validator.errors.any?
        self.class.new(validator.declared, @config)
      end
    end
  end
end

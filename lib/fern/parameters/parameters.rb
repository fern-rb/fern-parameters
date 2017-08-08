require 'active_support/core_ext/hash/indifferent_access'

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
        self.class.new(self.to_h, @config)
      end
    end
  end
end

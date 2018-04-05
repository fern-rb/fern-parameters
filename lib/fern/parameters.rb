require 'fern/parameters/dsl'
require 'fern/parameters/invalid'
require 'fern/parameters/parameters'

module Fern
  module Parameters
    extend ActiveSupport::Concern

    included do
      def params
        config = fern[action_name.to_sym][:params]
        @_params ||= Parameters.new(request.parameters, config)
      end

      def params=(val)
        @_params = Parameters.new(val.to_hash)
      end
    end
  end
end

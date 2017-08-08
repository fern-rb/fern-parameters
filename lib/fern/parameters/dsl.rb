require 'fern/api'

module Fern
  module Parameters
    module Dsl
      def self.included(receiver)
        receiver.extend(ClassMethods)
      end

      module ClassMethods
      end

      def params(&block)
        @controller.fern[@name][:params] = {}
        instance_eval(&block)
      end

      def param(name, type = :string, **opts)
        # Instead of just building a hash here, build up a higher order function
        # which validates an input value. The output of each validator function
        # should be the input to the next.
        #
        # ArrayValidator => IntegerValidator  => MinValidator(10)
        # FloatValidator => MinValidator(3.5) => MaxValidator(8.75)
        #
        # Maybe arrays don't have to be a special case if we use Array.wrap(val)
        # and assume all values are arrays.
        @controller.fern[@name][:params][name] = {
          type: type,
          constraints: opts
        }
      end
    end
  end
end

Fern::Api::Endpoint.class_eval { include Fern::Parameters::Dsl }

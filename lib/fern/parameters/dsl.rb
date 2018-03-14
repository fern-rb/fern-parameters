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
        @controller.fern[@name][:params][name] = {
          type: type,
          constraints: opts
        }
      end
    end
  end
end

Fern::Api::Endpoint.class_eval { include Fern::Parameters::Dsl }

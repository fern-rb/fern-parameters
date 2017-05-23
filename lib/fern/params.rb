require 'fern/api'

module Fern
  module Params
    def self.included(receiver)
      receiver.extend(ClassMethods)
    end

    module ClassMethods
    end

    def params(&block)
      instance_eval(&block)
    end

    def param(name, type = :string, **opts) end
  end
end

Fern::Api::Endpoint.class_eval { include Fern::Params }

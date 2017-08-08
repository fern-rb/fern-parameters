module Fern
  module Parameters
    module Validators
      class Validator
        def initialize(next_validator: nil, **kwargs)
          @next_validator = next_validator
        end

        def call(value)
          value = validate(value)
          return if value.nil?
          @next_validator.call(value) unless @next_validator.nil?
          value
        end
      end
    end
  end
end
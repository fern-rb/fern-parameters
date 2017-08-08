module Fern
  module Parameters
    module Validators
      class Min < Validator
        def initialize(min:, **kwargs)
          @min = min
          super(**kwargs)
        end

        def validate(value)
          return nil if value < @min
          value
        end
      end
    end
  end
end
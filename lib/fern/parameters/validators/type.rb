module Fern
  module Parameters
    module Validators
      class Type < Validator
        def initialize(type:, **kwargs)
          @type = type
          super(**kwargs)
        end

        def validate(value)
          Integer(value) rescue nil
        end
      end
    end
  end
end
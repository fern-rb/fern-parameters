# require 'fern/params/invalid'
# require 'fern/params/errors'

# module Fern
#   module Parameters
#     class Validator
#       attr_accessor :errors
#       attr_accessor :declared

#       def initialize(constraints)
#         @constraints = constraints
#         @errors = Errors.new
#         @declared = {}
#       end

#       def validate(params)
#         @constraints.each do |name, constraint|
#           if params.key?(name)
#             @declared[name] = validate_constraints(
#               name,
#               params[name],
#               constraint
#             )
#           else
#             @declared[name] = constraint[:default] if constraint.key?(:default)
#             @errors.add(name, 'is required') if constraint[:required]
#           end
#         end
#       end

#       private

#       def parse_type(val, type, array = false)
#         meth = "validate_#{type}"
#         if array
#           parsed = val.map { |el| self.send(meth, el) }
#           parsed.all? { |el| !el.nil? } && parsed
#         else
#           self.send(meth, val)
#         end
#       end

#       def validate_constraints(name, raw_val, constraints)
#         val = validate_type(name, raw_val, constraints)

#         return if val.nil?

#         validate_numeric_constraints(name, val, constraints)
#         validate_inclusion(name, val, constraints)

#         val
#       end

#       def validate_boolean(val)
#         val.casecmp('true').zero?
#       end

#       def validate_date(val)
#         Date.parse(val)
#       rescue ArgumentError
#       end

#       def validate_datetime(val)
#         DateTime.parse(val)
#       rescue ArgumentError
#       end

#       def validate_float(val)
#         Float(val)
#       rescue ArgumentError
#       end

#       def validate_inclusion(name, val, constraints)
#         return unless constraints.key?(:values)
#         return if constraints[:values].include?(val)
#         @errors.add(name, "must be one of #{constraints[:values]}")
#       end

#       def validate_integer(val)
#         Integer(val)
#       rescue ArgumentError
#       end

#       def validate_max(name, val, max)
#         return unless val > max
#         @errors.add(name, "must be less than or equal to #{max}")
#       end

#       def validate_min(name, val, min)
#         return unless val < min
#         @errors.add(name, "must be greater than or equal to #{min}")
#       end

#       def validate_numeric(name, val)
#         validate_float(val) || @errors.add(name, 'must be a number')
#       end

#       def validate_numeric_constraints(name, val, constraints)
#         return unless constraints.key?(:min) || constraints.key?(:max)
#         validate_numeric(name, val)
#         validate_min(name, val, constraints[:min]) if constraints.key?(:min)
#         validate_max(name, val, constraints[:max]) if constraints.key?(:max)
#       end

#       def validate_string(val)
#         val
#       end

#       def validate_type(name, val, constraints)
#         parsed = parse_type(val, constraints[:type], constraints[:array])
#         if parsed.nil?
#           @errors.add(name, "#{val} is not a #{constraints[:type]}")
#         end
#         parsed
#       end
#     end
#   end
# end

# module Fern
#   module Parameters
#     class Errors
#       def initialize
#         @errors = {}
#       end

#       def add(param, message)
#         @errors[param] ||= []
#         @errors[param] << message
#       end

#       def any?
#         @errors.any?
#       end

#       def [](param)
#         @errors[param]
#       end
#     end
#   end
# end

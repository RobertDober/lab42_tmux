# module SessionHelpers
#   module SessionSpecs extend self
#     def specs
#       @__specs__ = 
#         {
#           name: name_spec
#       }
#     end

#     def name_spec
#       @__name_spec__ ||=
#         -> name do
#           should include("tmux new-session -s #{name}")
#         end
#     end
#   end

# end # module SessionHelpers
# RSpec.configure do |c|
#   c.include SessionHelpers
# end


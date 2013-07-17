require 'lab42/tmux'
require 'forwarder'

module Lab42
  class Tmux
    module Predefined
      module AbstractSession
        attr_reader :tmux
        extend Forwarder
        forward_all :exec!, :render, to: :tmux
      end # module AbstractSession
    end # module Predefined
  end # class Tmux
end # module Lab42


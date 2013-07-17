require 'lab42/tmux/predefined/abstract_session'

module Lab42
  class Tmux
    module Predefined
      class TmuxSession
        include AbstractSession
        private
        def initialize *args, &blk
          @tmux = Lab42::Tmux.new args do
            add_window "repl", command: options.fetch(:repl,"irb") 
          end
        end 
      end # cmass TmuxSession
    end # module Predefined
  end # class Tmux
end # module Lab42

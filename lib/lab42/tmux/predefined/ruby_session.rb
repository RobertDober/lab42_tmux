require 'lab42/tmux'
require 'forwarder'

module Lab42
  class Tmux
    module Predefined
      class RubySession
        attr_reader :tmux
        extend Forwarder
        forward_all :exec!, :render, to: :tmux

        private
        def initialize *args, &blk
          @tmux = Lab42::Tmux.new args do
            add_window "repl", command: options.fetch(:repl,"irb") 
            add_window "vi", command: "vi ."
            # require 'pry'
            # binding.pry 
            if_dir "lib" do
              add_window "lib", command: "vi lib" do
                vim_command "colorscheme morning"
              end
            end
            if_dir "spec" do
              add_window "spec", command: "vi spec" do
                vim_commands "colorscheme solarized", background: "light"
              end
            end
            if_dir "features" do
              add_window "features", command: "vi features"
              add_window "cucu"
            end
            add_window "sh"
            # TODO: Specify this later if needed
            # instance_eval_or_call blk if blk
          end
        end 
      end # class RubySession
    end # module Predefined
  end # class Tmux
end # module Lab42

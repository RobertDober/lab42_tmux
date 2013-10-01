require 'lab42/tmux/predefined/abstract_session'
require 'forwarder'

module Lab42
  class Tmux
    module Predefined
      class NodeJS
        include AbstractSession

        private
        def initialize *args, &blk
          @tmux = Lab42::Tmux.new args do
            add_window "repl", command: options.fetch(:repl,"node") 
            add_window "vi", command: "vi ."
            # require 'pry'
            # binding.pry 
            if_dir "src" do
              add_window "src", command: "vi src" do
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
            if options[:rails_server]
              add_window "server", command: "bundle exec rails server"
            end
          end
        end 
      end # class NodeJS
    end # module Predefined
  end # class Tmux
end # module Lab42

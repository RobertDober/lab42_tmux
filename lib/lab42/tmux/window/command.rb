require 'forwarder'
require 'lab42/tmux/window/command/vim_command.rb'
module Lab42
  class Tmux
    class Window
      module Command
        include VimCommand
        extend Forwarder
        forward_all :lprefix, :session_name, :tmux, to: :session

        def tmux_new_window( rename: false )
          [ tmux( "new-window -t #{session_name}#{new_window_name}" ) ] +
            (rename ? [] : [
              tmux( "set-window-option -t #{designation} automatic-rename off" ),
              tmux( "set-window-option -t #{designation} allow-rename off" )
          ]) +
          [tmux_cd_project_home] +
          tmux_commands
        end

        def tmux_cd_project_home
          tmux_send_keys "cd #{session.project_home}"
        end

        def tmux_commands
          [(commands || [])].flatten.map{ |cmd|
            tmux_send_keys cmd
          }
        end
        def tmux_send_keys keys, cm: true
          tmux "send-keys -t #{designation} #{keys.inspect}#{lprefix( cm && "C-m" )}"
        end

        private
        def new_window_name
          with_present( :name ){ | name |
            " -n #{name}"
          }
        end

      end # module Command
    end # class Window
  end # class Tmux
end # module Lab42

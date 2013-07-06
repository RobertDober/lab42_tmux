require 'forwarder'
module Lab42
  class Tmux
    class Window
      module Command
        extend Forwarder
        forward_all :lprefix, :session_name, :tmux, to: :session

        def tmux_new_window( rename: false )
          [ tmux( "new-window -t #{session_name}" ) ] +
            (rename ? [] : [
              tmux( "set-window-option -t #{designation} automatic-rename off" ),
              tmux( "set-window-option -t #{designation} allow-rename off" )
          ])
        end

        def tmux_cd_project_home
          tmux_send_keys "cd #{session.project_home}"
        end

        def tmux_send_keys keys, cm: true
          tmux "send-keys  -t #{designation} #{keys.inspect}#{lprefix( cm && "C-m" )}"
        end

      end # module Command
    end # class Window
  end # class Tmux
end # module Lab42

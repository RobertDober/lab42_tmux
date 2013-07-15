require 'lab42/tmux/window/command'
require 'forwarder'
module Lab42
  class Tmux
    class Window
      include Command
      extend Forwarder
      attr_reader :command, :name, :number, :session
      forward_all :commands, :lprefix, :session_name, :tmux, to: :session

      def designation
        [session_name, number].join ":"
      end
      private
      def initialize nb, session, options={}
        @session = session
        @number  = nb
        @name    = options[:name]
        @command = options[:command]
        tmux_window_commands
      end

      def tmux_window_command cmd, params
        tmux "#{tmuxize cmd} -t #{designation} #{params}"
      end
      def tmux_window_commands
        tmux "new-window -t #{session_name}#{name ? " -n #{name}" : ""}"
        tmux_window_options
        tmux_cd_project_home
        tmux_send_keys command if command
      end

      def tmux_window_options( options: {} )
        [:automatic_rename, :allow_rename].each do |option|
          tmux_window_command :set_window_option, "#{tmuxize option} #{options[option] ? "on" : "off"}"
        end
      end

      def tmuxize sym
        sym.to_s.gsub "_", "-"
      end
    end # class Window
  end # class Tmux
end # module Lab42

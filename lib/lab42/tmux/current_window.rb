module Lab42
  class Tmux
    module CurrentWindow

      def tmux_current_window
        "-t #{tmux_current_window_designation}"
      end

      def tmux_current_window_command cmd, *args
        args = args.compact
        arguments = args.empty? ? "" : " #{args.join(" ")}"
        tmux "#{cmd} #{tmux_current_window}#{arguments}"
      end

      def tmux_current_window_designation
        [session_name, tmux_current_window_number].join(":")
      end
      def tmux_current_window_number
        @__tmux_current_window_number__ ||= 0
      end

      def tmux_current_window_number= new_val
        @__tmux_current_window_number__ = new_val
      end

    end # module CurrentWindow
  end # class Tmux
end # module Lab42

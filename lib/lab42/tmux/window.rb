require 'lab42/tmux/window/command'
module Lab42
  class Tmux
    class Window
      include Command
      attr_accessor :number, :session
      def designation
        [session.session_name, number].join ":"
      end
      def render
        [
          tmux_new_window,
          tmux_cd_project_home
        ].flatten
      end
      private
      def initialize nb, session
        self.session = session
        self.number  = nb
      end
    end # class Window
  end # class Tmux
end # module Lab42

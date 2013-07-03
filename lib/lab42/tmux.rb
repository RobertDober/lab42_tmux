require 'lab42/options'
require 'lab42/tmux/core_helpers'
require 'lab42/tmux/commands'
require 'lab42/tmux/window'

module Lab42
  class Tmux
    include Commands

    attr_accessor :options, :windows
    attr_reader   :project_home, :session_name

    def add_window &blk
      self.windows << Window.new( windows.size, self ) 
      instance_eval_or_call blk if blk
    end

    def current_window; windows.last end

    def exec!
      exec render
    end

    def render
      commands =
        render_session_commands +
        render_window_commands +
        render_final_attach_command

      commands.join "\n"
    end

    private
    def initialize &blk
      self.options = Lab42::Options.new.parse( *ARGV.dup )
      process_options
      raise ArgumentError, "unable to determine session name" unless session_name
      raise ArgumentError, "no such directory #{project_home}" unless project_home && File.directory?( project_home )
      self.windows = [Window.new( 0, self )]
      instance_eval_or_call blk
    end


    def process_options
      @project_home = options.args.first
      @session_name = File.basename project_home rescue nil
    end

    def render_session_commands
      [
        tmux_new_session,
        tmux_source_file,
        tmux_no_session_rename
      ].compact
    end

    def render_final_attach_command
      [
        tmux( "attach -t #{session_name}" )
      ]
    end

    def render_window_commands
      windows.map(&:render).flatten
    end
  end
end # module Lab42

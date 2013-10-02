require 'lab42/options'
require 'lab42/tmux/core_helpers'
require 'lab42/tmux/commands'
require 'lab42/tmux/command'
require 'lab42/tmux/window'
require 'lab42/tmux/extensions/ostruct'
require 'lab42/tmux/extensions/hash'
require 'lab42/tmux/extensions/object'
require 'lab42/tmux/helpers'

module Lab42
  class Tmux
    include Commands
    include Command
    include Helpers

    attr_reader :commands, :options, :project_home, :session_name, :windows, :yaml_file_name

    def add_window name=nil, options={}, &blk
      window =  Window.new windows.size.succ, self, name: name, command: options[:command]
      windows << window

      window.instance_eval_or_call blk if blk
    end

    def current_window; windows.last end
    def current_window?; !!current_window end

    def exec!
      if options.dry_run
        puts render
      else
        exec render
      end
    end

    def render
      (commands + final_attach_command).join "\n"
    end

    private
    def initialize args, &blk
      @options = Lab42::Options.new.parse( *args.dup )
      @commands = []
      @windows = []
      process_options
      raise ArgumentError, "unable to determine session name" unless session_name
      session_commands
      instance_eval_or_call blk
    end

    def determine_yaml_or_dir
      if @yaml_file_name = File::YAML.exists?( project_home )
      else
        raise ArgumentError, "#{project_home} is neither a yaml file or directory (yaml files are looked for with an added .yaml or .yml extension)" unless
          File.directory? project_home
      end
    end

    def final_attach_command
      [
        "tmux attach -t #{session_name}"
      ]
    end

    def process_options
      @project_home = options.args.first
      @project_home = File.join Dir.pwd, @project_home unless
        !@project_home || %r{\A[/~]} === @project_home
      determine_yaml_or_dir if project_home
      process_yaml_file
      @session_name ||= File.basename project_home rescue nil
    end

    def process_yaml_file
      return unless yaml_file_name
      # TODO: Handle YAML errors from YAML.load
      yaml_content = YAML.load( File.read yaml_file_name )
    end

    def session_commands
      return if session_exists?
      tmux_new_session
      tmux_source_file
    end

    def session_exists?
      return false if options.dry_run
      system "tmux has-session -t #{session_name}"
      $?.to_i.zero?
    end
  end
end # module Lab42

require 'lab42/options'
require 'lab42/tmux/core_helpers'
require 'lab42/tmux/commands'
require 'lab42/tmux/command'
require 'lab42/tmux/window'
require 'lab42/tmux/extensions/enumerable'
require 'lab42/tmux/extensions/file'
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
      version! args.first
      @options = Lab42::Options.new
      yaml_or_project_home args.first
      @options = @options.parse( *args.dup )
      @commands = []
      @windows = []
      set_basic_ivars
      raise ArgumentError, "unable to determine session name" unless session_name
      session_commands
      instance_eval_or_call blk
    end

    def yaml_or_project_home fn
      f = File.absolute_path fn
      if @yaml_file_name = File::YAML.exists?( f )
        @options.read_from @yaml_file_name
      else
        if File.directory? f
          @project_home = f
        else
          @yaml_file_name = File::YAML.exists?( fn,search_path: File.join(ENV["HOME"],".lab42_tmux","yaml_files"))
          raise ArgumentError, "#{fn} is neither a yaml file nor a directory (yaml files are looked for with an added .yaml or .yml extension)" unless @yaml_file_name
          @options.read_from @yaml_file_name
        end
      end
    end

    def final_attach_command
      [
        "tmux attach -t #{session_name}"
      ]
    end

    def set_basic_ivars
      @session_name = @options.fetch :session_name, nil
      @project_home ||= @options.fetch :project_home, nil
      @session_name ||= File.basename project_home rescue nil
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

    def version! arg
      require 'lab42/tmux/version'
      if %r{\A(?::|--)version\z} === arg
        puts Lab42::Tmux::VERSION
        exit -1
      end
    end
  end
end # module Lab42

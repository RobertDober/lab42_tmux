require 'lab42/options'
require 'lab42/tmux/core_helpers'

module Lab42
  class Tmux
    attr_accessor :options
    attr_reader   :project_home, :session_name

    def initialize &blk
      self.options = Lab42::Options.new.parse( *ARGV.dup )
      process_options
      raise ArgumentError, "unable to determine session name" unless session_name
      raise ArgumentError, "no such directory #{project_home}" unless project_home && File.directory?( project_home )
      instance_eval_or_call blk
    end


    private
    def process_options
      @project_home = options.args.first
      @session_name = File.basename project_home rescue nil
    end
  end
end # module Lab42

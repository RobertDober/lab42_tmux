module Lab42
  class Tmux
    module Helpers
      def if_dir dir, &blk
        return unless File.directory? expand_dir dir
        instance_eval_or_call blk
      end

      def expand_dir dir
        return dir if %r{\A/} === dir
        File.join project_home, dir
      end
    end # module Helpers
  end # class Tmux
end # module Lab42

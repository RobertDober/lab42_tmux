module Lab42
  class Tmux
    module Commands
      attr_accessor :window_count
      def tmux cmd; commands << "tmux #{cmd}" end

      def tmux_new_session cmd=nil
        tmux "new-session -s #{session_name} -d#{lprefix cmd}"
      end

      def tmux_no_session_rename
        tmux "set-window-option -g automatic-rename off" unless options.no_session_rename
      end

      def tmux_source_file
        tmux "source-file #{options.source_file || File.join( ENV["HOME"], ".tmux.conf" )}"
      end

      def lprefix cmd, prefix=" "
        cmd ? "#{prefix}#{cmd}" : ""
      end

    end # module Commands
  end # class Tmux
end # module Lab42

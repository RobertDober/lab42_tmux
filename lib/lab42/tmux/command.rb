require 'lab42/tmux/current_window'
class Array
  def mk_string *args, &blk
    args = [' '] if args.empty?
    compact.join( *args, &blk )
  end
end # class Array

module Lab42
  class Tmux
    module Command
      include CurrentWindow

      # def tmux_execute_window_commands
      #   ( @tmux_window_precommands || [] ).each do | blk |
      #     blk.()
      #   end
      # end

      def tmux_increase_current_window_number by=1
        self.tmux_current_window_number += by
      end

      # tmux new-session -s $session_name -n console -d
      def tmux_new_session params=nil
        if session_exists?
          system "tmux attach -t #{session_name}"
          exit 0
        end
        suffix = params ? " #{params}" : ""
        tmux "new-session -s #{session_name} -d#{suffix}"
        unless @options.no_source_file || @options.tmux_source_file.nil?
          tmux "source-file #{@options.tmux_source_file}"
        end
        tmux "set-window-option -g automatic-rename off"
        unless @options.no_cd
          tmux_project_home
        end
      end

      def tmux_new_window name=nil, dir=nil
        tmux_increase_current_window_number
        suffix = name ? %{ -n "#{name}"} : nil
        tmux "new-window -t #{@options.session_name}#{suffix}"
        tmux_set_window_options "automatic-rename off", "allow-rename off"
        tmux_project_home dir
        tmux_execute_window_commands
      end

      def tmux_open_vim options={}
        dir = options.delete( :dir ){ "." }
        tmux_send_keys "vi #{dir}"
        options.each do | cmd, params |
          command = ":#{[cmd,params].compact.join(" ")}"
        tmux_send_keys command
        end
      end

      def tmux_open_irb options={}
        lib = options.delete( :lib ){ "./lib" }
        tmux_send_keys "irb -I#{lib}"
      end

      def tmux_prefixed_command cmd, eol=true
        tmux_send_keys [@options.cmd_prefix, cmd].mk_string, eol
      end

      def tmux_project_home dir=project_home
        dir = File.join project_home, dir if dir && %r{\A[^/~]} === dir
        tmux_send_keys "cd #{dir}" 
      end

      def tmux_register_window_command noexec=false, &blk
        blk.() unless noexec
        @tmux_window_precommands ||= []
        @tmux_window_precommands << blk
      end

      def tmux_send_keys keys, eol=true
        suffix = eol ? " C-m" : nil 
        tmux_current_window_command "send-keys", %{"#{keys}"}, suffix
      end

      def tmux_set_window_option option
        tmux_current_window_command "set-window-option", option
      end

      def tmux_set_window_options *options
        options.each do | option |
          tmux_set_window_option option
        end
      end
    end
  end
end

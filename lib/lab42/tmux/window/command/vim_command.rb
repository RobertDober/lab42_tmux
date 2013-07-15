module Lab42
  class Tmux
    class Window
      module Command
        module VimCommand
          def vim_commands *cmds
            cmds.each do | cmd |
              vim_command cmd
            end
          end

          def vim_command cmd
            case cmd
            when Hash
              vim_set_commands cmd
            else
              tmux_send_keys ":#{cmd}"
            end
          end

          def vim_set_commands set_cmds
            set_cmds.each do |key, val|
              tmux_send_keys ":set #{key}=#{val}"
            end
          end
        end # module VimCommand
      end # module Command
    end # class Window
  end # class Tmux
end # module Lab42

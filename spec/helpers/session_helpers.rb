module SessionHelpers
  module SessionSpecs extend self
    def specs
      @__specs__ = 
        {
          name: name_spec
      }
    end

    def name_spec
      @__name_spec__ ||=
        -> name do
          should include("tmux new-session -s #{name}")
        end
    end
  end

  def current_window
    [session_name, @window_count].join ":"
  end

  def changes_to_dir dir
    should include(%{tmux send-keys -t #{current_window} "cd #{dir}"})
  end

  def go_home
    %{tmux send-keys -t #{current_window} "cd #{project_home}" C-m\n}
  end

  def opens_a_tmux_session specs
    @window_count = 0 
    specs.each do | key, val |
      instance_exec(val, &SessionSpecs.specs.fetch(key){ raise ArgumentError, "cannot specify this session parameter : #{key}"})
    end
  end

  def opens_a_window specs
    @window_count += 1
    name = specs.fetch :named
    with_command = specs[:with_command]
    cm = specs[:no_cm] ? "" : " C-m"
    should include("tmux new-window -t #{session_name} -n #{name}")
    should include("tmux set-window-option -t #{current_window} automatic-rename off") 
    should include("tmux set-window-option -t #{current_window} allow-rename off") 
    return unless with_command
    should include("#{go_home}tmux send-keys -t #{current_window} \"#{with_command}\"#{cm}")
  end
  
  def sends_keys keys
    should include( %{tmux send-keys -t #{current_window} "#{keys}" C-m} )
  end
end # module SessionHelpers
RSpec.configure do |c|
  c.include SessionHelpers
end


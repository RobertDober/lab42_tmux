def verify_sent_keys keys, win_number: 0, c_m: true
  all_output.should include("@ send-keys -t #{window_name number: win_number} #{keys}#{c_m ? " C-m" : ""}") 
end
def verify_window_opened( number: 1 )
  # tmux set-window-option -t alpha:2 automatic-rename off
  # tmux set-window-option -t alpha:2 allow-rename off
  # tmux send-keys -t alpha:2 "cd alpha"  C-m
  step %{the output should contain "@ set-window-option -t #{window_name number: number} automatic-rename off"}
  step %{the output should contain "@ set-window-option -t #{window_name number: number} allow-rename off"}
  verify_sent_keys "cd #@project_dir", win_number: number
end



def verify_sent_keys keys, win_number: 0, c_m: true
  all_output.should include("@ send-keys -t #{window_name number: win_number} #{keys}#{c_m ? " C-m" : ""}") 
end
def verify_window_opened( name, number: 1 )
  step %{it shall open a window named "#{name}"}
  step %{the output should contain "@ set-window-option -t #{window_name number: number} automatic-rename off"}
  step %{the output should contain "@ set-window-option -t #{window_name number: number} allow-rename off"}
  verify_sent_keys "cd #@project_dir", win_number: number
end



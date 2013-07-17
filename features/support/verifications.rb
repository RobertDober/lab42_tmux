def verify_changed_to dir, win_number: 0, c_m: true
  dir = File.join Dir.pwd, "tmp", "aruba", dir unless %r{\A[/~]} === dir
  verify_sent_keys "cd #{dir}", win_number: win_number, c_m: c_m
end
def verify_sent_keys keys, win_number: 0, c_m: true
  all_output.should include("@ send-keys -t #{window_name number: win_number} #{keys}#{c_m ? " C-m" : ""}") 
end
def verify_window_opened( name, number: 1 )
  step %{it shall open a window named "#{name}"}
  step %{the output should contain "@ set-window-option -t #{window_name number: number} automatic-rename off"}
  step %{the output should contain "@ set-window-option -t #{window_name number: number} allow-rename off"}
  verify_changed_to @project_dir, win_number: number
end



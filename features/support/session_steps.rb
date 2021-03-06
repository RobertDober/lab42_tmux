Then(/^it shall open a tmux session with name "(.*?)"$/) do | session_name |
  @session_name = session_name
  File.new File.join(PROJECT_ROOT, "fixes", "#{session_name}.session"), "a"
  @project_dir = @args.first
  step %{the output should contain "@ new-session -s #{session_name} -d"}
  step %{the output should contain "@ source-file #{File.join ENV["HOME"], '.tmux.conf'}"}
  step %{the output should contain "@ set-window-option -g automatic-rename off"}
  # verify_sent_keys %{cd #@project_dir}
  verify_changed_to @project_dir
end

Then(/^it shall open a tmux session with name specified in the yaml file$/) do
  session_name = @yaml_file_content.fetch "session_name", @yaml_file_name
  step %{it shall open a tmux session with name "#{session_name}"}
end

Then(/^it shall open a tmux session with name "(.*?)" in the project_home$/) do |session_name|
  step %{it shall open a tmux session with name "#{session_name}"}

end


Then(/^it shall attach to the tmux session$/) do
  @new_output.should include("@ attach -t #{@session_name}")
end

Then(/^it shall not open a(?:nother)? tmux session$/) do
  (@new_output||all_output).should_not include("@ new-session")
end

Then(/^it shall attach to the new session at the end$/) do
  all_output.should match(/@ attach -t #{@session_name}\r?\n?\z/)
end
Then(/^it shall not attach to a tmux session$/) do
  step %{the output should not contain "@ attach -t"}
end

Then(/^it shall print the tmux commands$/) do
  all_output.should include("tmux new-session -s #@session_name")
end


Then(/^it shall not open any new windows$/) do
  step %{the output should not contain "@ new-window -t"}
end
Then(/^it shall open (\d+) additional windows$/) do |wincount|
  @session_name.should be_true
  step %{the output should contain "@ new-window -t #@session_name"}
  count = wincount.to_i
  count.times do |n|
    verify_window_opened number: n.succ
  end
end
Then /\Ait shall open (\d+) windows?\z/ do | n |
  all_output.scan(%r{@ new-window -t #{@session_name}}).size.should eq( n.to_i )
end
Then(/^it shall open only one window$/) do
  step %{it shall open 1 window}
end

Then(/^it shall open a window named "([^"]*)"$/) do |win_name|
  step %{the output should contain "@ new-window -t #@session_name -n #{win_name}"}
end


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

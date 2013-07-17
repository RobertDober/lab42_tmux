Then(/^the output should match "(.*?)"$/) do |rgx|
  all_output.should match( Regexp.new rgx )
end


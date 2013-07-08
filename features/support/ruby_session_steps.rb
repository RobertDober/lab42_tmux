
def should_have_window hash, nb: required
  step %{it shall open a window named "#{hash[:name]}"}
end

Then(/^it shall open the following windows:$/) do |table|
  #    table is a Cucumber::Ast::Table
  # require 'pry'
  # binding.pry
  table.hashes.each_with_index do |hash, idx|
    should_have_window hash, nb: idx.succ
  end
end

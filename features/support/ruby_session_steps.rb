
def should_have_window hash, nb: required
  verify_window_opened hash[:name], number: nb
  verify_sent_keys hash[:command], win_number: nb unless hash[:command].empty?
end

Then(/^it shall open the following windows:$/) do |table|
  #    table is a Cucumber::Ast::Table
  # require 'pry'
  # binding.pry
  table.hashes.each_with_index do |hash, idx|
    should_have_window hash, nb: idx.succ
  end
end

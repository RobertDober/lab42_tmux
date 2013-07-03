When /\AI run lab42_(\w+)\s*\z/ do | cmd |
  step "I run `#{File.join PROJECT_ROOT, "bin", "lab42_#{cmd}"}`"
end
When /\AI run lab42_(\w+)\s+(.*)\z/ do | cmd, args |
  @args = args.split
  @cmd  = cmd
  step "I run `#{File.join PROJECT_ROOT, "bin", "lab42_#{cmd}"} #{args}`"
  File.new File.join( PROJECT_ROOT, "fixes", "#{File.basename args.split.first}.session"), "a"
end 

When(/^I rerun lab42_(\w+) (.*)$/) do |cmd, args|
  orig_length = all_output.size
  step "I run `#{File.join PROJECT_ROOT, "bin", "lab42_#{cmd} #{args}"}`"
  @new_output = all_output[orig_length..-1]
end

Then /\Athe exit status should be -(\d+)\z/ do |negstat|
  step "the exit status should be #{256-negstat.to_i}"
end

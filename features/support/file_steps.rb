Given(/^the directories (.*)/) do |dirs|
  dirs.strip.split( /\s*,\s*/ ).each do | dir |
    step %{a directory named "#{dir}"}
  end
end


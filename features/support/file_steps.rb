Given(/^the director(?:(?:y)|(?:ies)) (.*)/) do |dirs|
  dirs.strip.split( /\s*,\s*/ ).each do | dir |
    step %{a directory named "#{dir}"}
  end
end

Given(/^the yaml file (\w+) with the following content$/) do |fn, table|
  @yaml_file_name = fn.sub /(?<=.)[^.*]\z/, ""
end


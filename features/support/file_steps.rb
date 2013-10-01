Given(/^the director(?:(?:y)|(?:ies)) (.*)/) do |dirs|
  dirs.strip.split( /\s*,\s*/ ).each do | dir |
    step %{a directory named "#{dir}"}
  end
end

Given(/^the yaml file (\w+) with the following content:$/) do |fn, table|
  @yaml_file_name = fn.sub /(?<=\.)[^.*]\z/, ""
  step %{an empty file named "#{@yaml_file_name}.yml"}
  @yaml_file_content = table.hashes.inject({}) do | content, t_entry |
    content.merge Hash[*t_entry.values_at( "key", "value" )]
  end
end


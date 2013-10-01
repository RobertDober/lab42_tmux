PROJECT_ROOT = File.expand_path "../..", __FILE__
$:.unshift File.join( PROJECT_ROOT, "lib" )
Dir[File.join(PROJECT_ROOT,"spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |c|
  c.treat_symbols_as_metadata_keys_with_true_values = true
  c.color_enabled = true
  c.run_all_when_everything_filtered = true
  c.include SessionHelpers
end

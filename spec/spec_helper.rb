$:.unshift( File.expand_path( "../../lib", __FILE__ ))
require_relative './helpers/setup'
require_relative './helpers/session_helpers'
require_relative './helpers/window_helpers'

RSpec.configure do |c|
  c.treat_symbols_as_metadata_keys_with_true_values = true
  c.color_enabled = true
  c.run_all_when_everything_filtered = true
  c.include SessionHelpers
end

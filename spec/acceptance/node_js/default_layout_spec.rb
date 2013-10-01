require 'spec_helper'
require 'lab42/tmux/predefined/nodejs'

describe "NodeJS Session Default Layout", :focus do 
 
  before do
    given directories: %w{~/nodeproject ~/nodeproject/src ~/nodeproject/spec}
  end
  subject do
    Lab42::Tmux::Predefined::NodeJS.new(project_home, ":dry_run" ).render
  end
  let(:session_name){"nodeproject"}
  let(:project_home){"~/nodeproject"}

  it {
    opens_a_tmux_session name: session_name
    changes_to_dir project_home
    opens_a_window named: "repl", with_command: "node"
    opens_a_window named: "vi", with_command: "vi ."
    opens_a_window named: "src", with_command: "vi src"
    sends_keys ":colorscheme morning"
    opens_a_window named: "spec", with_command: "vi spec"
    sends_keys ":colorscheme solarized"
    sends_keys ":set background=light"
    # opens_a_window named: "features", with_command: "vi features"
    opens_a_window named: "cucu"
  }
end # describe "NodeJS Session Default Layout"

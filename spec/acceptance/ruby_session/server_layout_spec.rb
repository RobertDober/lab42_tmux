require 'spec_helper'
require 'lab42/tmux/predefined/ruby_session'

# TODO: wip and implement this
describe "Ruby Session Default Layout" do 
 
  before do
    given directories: %w{~/ruby/mygem ~/ruby/mygem/lib ~/ruby/mygem/spec ~/ruby/mygem/features}
  end
  subject do
    Lab42::Tmux::Predefined::RubySession.new(project_home, ":dry_run", ":rails_server" ).render
  end
  let(:session_name){"mygem"}
  let(:project_home){"~/ruby/mygem"}

  it {
    opens_a_tmux_session name: session_name
    changes_to_dir File.expand_path(project_home)
    opens_a_window named: "repl", with_command: "irb"
    opens_a_window named: "vi", with_command: "vi ."
    opens_a_window named: "lib", with_command: "vi lib"
    sends_keys ":colorscheme morning"
    opens_a_window named: "spec", with_command: "vi spec"
    sends_keys ":colorscheme solarized"
    sends_keys ":set background=light"
    opens_a_window named: "features", with_command: "vi features"
    opens_a_window named: "cucu"
    opens_a_window named: "sh"
    opens_a_window named: "server", with_command: "bundle exec rails server"
  }
end # describe "Ruby Session Default Layout"

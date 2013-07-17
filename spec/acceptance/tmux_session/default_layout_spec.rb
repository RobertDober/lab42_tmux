require 'spec_helper'
require 'lab42/tmux/predefined/tmux_session'

describe "Tmux Session Default Layout", :focus do 
 
  before do
    given directories: project_home
  end
  subject do
    Lab42::Tmux::Predefined::TmuxSession.new(project_home, ":dry_run" ).render
  end
  let(:session_name){"mygem"}
  let(:project_home){"~/ruby/mygem"}

  it {
    opens_a_tmux_session name: session_name
    changes_to_dir project_home
  }
end # describe "Tmux Session Default Layout"


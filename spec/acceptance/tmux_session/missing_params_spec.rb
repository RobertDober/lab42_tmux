require 'spec_helper'
require 'lab42/tmux/predefined/tmux_session'

describe "Tmux Session Default Layout" do 
 
  context "missing params", :focus do
    it "shall raise an Argument Error" do
      -> { 
        Lab42::Tmux::Predefined::TmuxSession.new(":dry_run")
      }.should raise_error( ArgumentError, /unable to determine session name/ )
    end
  end
end # describe "Tmux Session Default Layout"


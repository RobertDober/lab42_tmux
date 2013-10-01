require 'spec_helper'
require 'lab42/tmux/predefined/tmux_session'

describe 'Tmux Session Load From YAML File', :wip do
  
  context "given a yaml file" do 
    before do
      given directory: param,
        yaml_file: param,
        with_yaml_content: { session_name: "a", project_home: project_home, vi: true }
      
    end
    let(:project_home){"~/ruby/mygem"}
    let(:param){"xxx"}
    subject do
      Lab42::Tmux::Predefined::TmuxSession.new( param, ":dry_run" ).render
    end
    it do
      require 'pry'
      binding.pry 
      subject
    end
  end # context "given a yaml file"
end # describe 'Tmux Session Load From YAML File'

require 'spec_helper'
require 'lab42/tmux/predefined/tmux_session'

describe 'Tmux Session Load From YAML File', :wip do
  
  context "given a yaml file" do 
    before do
      given directory: param,
        yaml_file: yaml_file,
        with_yaml_content: { session_name: session_name, project_home: project_home, vi: true },
        current_dir: File.dirname( yaml_file )
    end

    let(:project_home){"~/ruby/mygem"}
    let(:yaml_file){"/some/path/xxx.yml"}
    let(:param){"xxx"}
    let(:session_name){ "a session" }

    subject do
      Lab42::Tmux::Predefined::TmuxSession.new( param, ":dry_run" ).render
    end
    it do
      opens_a_tmux_session name: session_name
      changes_to_dir project_home
    end
  end # context "given a yaml file"
end # describe 'Tmux Session Load From YAML File'

require 'spec_helper'
require 'lab42/tmux/predefined/tmux_session'

describe 'Tmux Session Load From YAML File' do
  
  let(:project_home){"~/ruby/mygem"}
  let(:session_name){ "a_session" }

  context "given a yaml file" do 
    before do
      given directory: param,
        yaml_file: yaml_file,
        with_yaml_content: { session_name: session_name, project_home: project_home, vi: true },
        current_dir: File.dirname( yaml_file )
    end

    let(:yaml_file){"xxx.yml"}
    let(:param){"xxx"}

    subject do
      Lab42::Tmux::Predefined::TmuxSession.new( param, ":dry_run" ).render
    end
    it do
      opens_a_tmux_session name: session_name
      changes_to_dir project_home
    end
  end # context "given a yaml file"

  context "given a yaml file in the search path" do

    before do
      given directory: yaml_file_dir,
        yaml_file: yaml_file_in_dir,
        with_yaml_content: { session_name: session_name, project_home: project_home, vi: true }
    end

    let(:yaml_file_base_name){"myyamlfile"}
    let(:yaml_file_dir){File.join(ENV["HOME"], ".lab42_tmux", "yaml_files")}
    let(:yaml_file_in_dir){File.join yaml_file_dir, "#{yaml_file_base_name}.yaml"}

    subject do
      Lab42::Tmux::Predefined::TmuxSession.new( yaml_file_base_name, ":dry_run" ).render
    end
    it do
      opens_a_tmux_session name: session_name
      changes_to_dir project_home
    end
  end # context "given a yaml file in the search path"
end # describe 'Tmux Session Load From YAML File'

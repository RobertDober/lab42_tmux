require 'spec_helper'
require 'lab42/tmux/extensions/file'

describe File::YAML do

  subject do
    described_class
  end

  context :exists? do 

    it "returns nil in case of no file" do
      expect( subject.exists? "no such file", search_path: [] ).to be_false
    end

    context "the .yaml file exists" do
      before do
        stub_files "xxx.yaml"
      end
      it "returns it for the exact name" do
        expect( subject.exists? "xxx.yaml", search_path: [] ).to eq( "xxx.yaml" )
      end
      it "returns it for the name without extension" do
        expect( subject.exists? "xxx", search_path: [] ).to eq( "xxx.yaml" )
      end
      it "returns nil for .yml name" do
        expect( subject.exists? "xxx.yml", search_path: [] ).to be_false
      end
    end # context "the .yaml file exists"
    

    context "the .yml file exists" do
      before do
        stub_files "xxx.yml"
      end
      it "returns it for the exact name" do
        expect( subject.exists? "xxx.yml", search_path: [] ).to eq( "xxx.yml" )
      end
      it "returns it for the name without extension" do
        expect( subject.exists? "xxx", search_path: [] ).to eq( "xxx.yml" )
      end
      it "returns nil for .yaml name" do
        expect( subject.exists? "xxx.yaml", search_path: [] ).to be_false
      end
    end # context "the .yml file exists"
    
    context "the .yaml and .yml file exists" do
      before do
        stub_files "xxx.yaml", "xxx.yml"
      end
      it "returns it for the exact name" do
        expect( subject.exists? "xxx.yaml", search_path: [] ).to eq( "xxx.yaml" )
      end
      it "returns it for the name without extension" do
        expect( subject.exists? "xxx", search_path: [] ).to eq( "xxx.yaml" )
      end
      it "returns .yml for the yml name" do
        expect( subject.exists? "xxx.yml", search_path: [] ).to eq( "xxx.yml" )
      end
    end # context "the .yaml and .yml file exists"
    
    context "lookup" do
      let(:search_path){ File.join ENV["HOME"], ".lab42_tmux", "yaml_files" }
      let(:xxx_name){ File.join search_path, "xxx.yml" }
      let(:yyy_name){ File.join search_path, "yyy.yaml" }

      before do
        stub_files xxx_name, yyy_name
      end
      it "returns the exact name" do
        expect( subject.exists? "xxx.yml", search_path: search_path ).to eq( xxx_name )
        expect( subject.exists? "yyy.yaml", search_path: search_path ).to eq( yyy_name )
      end
      it "returns the exact name (indicated without extension)" do
        expect( subject.exists? "xxx", search_path: search_path ).to eq( xxx_name )
        expect( subject.exists? "yyy", search_path: search_path ).to eq( yyy_name )
      end
      it "returns false (in case of an incorrect extension)" do
        expect( subject.exists? "xxx.yaml", search_path: search_path ).to be_false
        expect( subject.exists? "yyy.yml",  search_path: search_path ).to be_false
      end
    end # context "lookup"
  end # context :exists?
end # describe File::YAML

require 'spec_helper'
require 'lab42/tmux/extensions/file'

describe File::YAML do

  subject do
    described_class
  end

  context :exists? do 

    it "returns nil in case of no file" do
      expect( subject.exists? "no such file" ).to be_false
    end

    context "the .yaml file exists" do
      before do
        stub_files "xxx.yaml"
      end
      it "returns it for the exact name" do
        expect( subject.exists? "xxx.yaml" ).to eq( "xxx.yaml" )
      end
      it "returns it for the name without extension" do
        expect( subject.exists? "xxx" ).to eq( "xxx.yaml" )
      end
      it "returns nil for .yml name" do
        expect( subject.exists? "xxx.yml" ).to be_false
      end
    end # context "the .yaml file exists"
    

    context "the .yml file exists" do
      before do
        stub_files "xxx.yml"
      end
      it "returns it for the exact name" do
        expect( subject.exists? "xxx.yml" ).to eq( "xxx.yml" )
      end
      it "returns it for the name without extension" do
        expect( subject.exists? "xxx" ).to eq( "xxx.yml" )
      end
      it "returns nil for .yaml name" do
        expect( subject.exists? "xxx.yaml" ).to be_false
      end
    end # context "the .yml file exists"
    
    context "the .yaml and .yml file exists" do
      before do
        stub_files "xxx.yaml", "xxx.yml"
      end
      it "returns it for the exact name" do
        expect( subject.exists? "xxx.yaml" ).to eq( "xxx.yaml" )
      end
      it "returns it for the name without extension" do
        expect( subject.exists? "xxx" ).to eq( "xxx.yaml" )
      end
      it "returns .yml for the yml name" do
        expect( subject.exists? "xxx.yml" ).to eq( "xxx.yml" )
      end
    end # context "the .yaml and .yml file exists"
    
  end # context :exists?
end # describe File::YAML

require 'lab42/tmux'

describe Hash do
  subject{ {a: 43 } }
  describe :with_present do 
    it "returns nil for absent keys" do
      subject.with_present(:b){ 44 }.should be_nil
    end
    it "returns the block for present keys" do
      subject.with_present(:a,&:pred).should eq( 42 )
    end
  end # describe :with_present
end # describe Hash

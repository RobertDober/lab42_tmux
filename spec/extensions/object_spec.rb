require 'lab42/tmux'

describe Object do
  subject do
    Module.new do
      extend self
      attr_accessor :a
    end
  end
  describe :with_present do 
    it "returns nil for absent properties" do
      subject.with_present(:b){ 44 }.should be_nil
    end
    it "returns the block for present properties" do
      subject.a = 44
      subject.with_present(:a, &:pred).should eq( 43 )
    end
  end # describe :with_present
end # describe Hash

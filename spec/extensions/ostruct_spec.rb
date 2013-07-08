require 'lab42/tmux'

describe OpenStruct do 
  subject{
    OpenStruct.new a: 42
  }
  describe :fetch do 
    context "existing key" do 
      it "fetches existing value" do
        subject.fetch(:a).should eq(42)
      end
    end # context
    context "no such key" do 
      it "raises an IndexError" do
        ->{ subject.fetch :b }.should raise_error(IndexError)
      end
      it "returns default values" do
        subject.fetch(:b,1).should eq(1)
        subject.fetch(:b){2}.should eq(2)
      end
    end # context "no such key"
  end # describe :fetch
end # describe OpenStruct

module FileHelpers
  def stub_files *fns
    File.stub(:readable?){ |f| fns.include? f }
  end
end # module FileHelpers
RSpec.configure do |c|
  c.include FileHelpers
end

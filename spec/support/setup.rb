module Setup extend self

  def _dir_setup 
    -> dirs do
      File.stub(:directory?){ |dir| dirs.include? dir }
    end
  end
  def setups
    @__setups__ ||=
      {
      directory: _dir_setup,
      directories: _dir_setup
    }
  end

  def given entities={}
    entities.each do |key, val|
      setup_entity key, val
    end
  end

  def setup_entity key, val
    setups.fetch(key){ raise ArgumentError, "no such entity to be setup: #{key}" }
    .( val )
  end

end

RSpec.configure do |c|
  c.include Setup
end

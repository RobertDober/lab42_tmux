module Setup extend self

  def _dir_setup 
    -> dirs do
      File.stub(:directory?){ |dir| dirs.include? dir }
    end
  end

  def _dir_pwd_setup
    -> dir do
      Dir.stub(:pwd){ dir }
    end
  end
  def _yaml_content_setup
    require 'yaml'
    -> yaml_content do
      file_placeholder = Object.new
      File.stub(:read){ file_placeholder }
      YAML.stub(:load){ |c| c==file_placeholder && yaml_content }
    end
  end

  def _yaml_file_setup
    -> yml_file do
      File.stub :readable? do |f|
        # puts "stubbed: #{yml_file}, checking: #{f}"
        yml_file == f
      end
    end
  end

  def setups
    @__setups__ ||=
      {
      current_dir: _dir_pwd_setup,
      directory: _dir_setup,
      directories: _dir_setup,
      with_yaml_content: _yaml_content_setup,
      yaml_file: _yaml_file_setup,
    }
  end

  def given entities={}
    entities.each do |key, val|
      setup_entity key, val
    end
  end

  def setup_entity key, val
    prc = setups.fetch(key){ raise ArgumentError, "no such entity to be setup: #{key}" }
    # require 'pry'
    # binding.pry 
    prc.( val )
  end

end

RSpec.configure do |c|
  c.include Setup
end

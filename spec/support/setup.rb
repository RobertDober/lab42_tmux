module Setup extend self

  def _dir_setup 
    -> dirs do
      File.stub(:directory?){ |dir| dirs.include? dir }
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
      File.stub(:readable?){ |fn| "#{yml_file}.yml" == fn }
    end
  end

  def setups
    @__setups__ ||=
      {
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
    setups.fetch(key){ raise ArgumentError, "no such entity to be setup: #{key}" }
    .( val )
  end

end

RSpec.configure do |c|
  c.include Setup
end

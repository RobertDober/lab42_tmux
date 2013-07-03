$:.unshift( File.expand_path( "../lib", __FILE__ ) )
require 'lab42/tmux/version'

version = Lab42::Tmux::VERSION
Gem::Specification.new do |s|
  s.name        = 'lab42_tmux'
  s.version     = version
  s.summary     = "Creating Tmux Windows And Panes Without Pains"
  s.description = %{A Gem that will give us helpers to dry up the creation of TMUX windows and panes, adding some predefind layouts which are a good starting point for the usage of this gem}
  s.authors     = ["Robert Dober"]
  s.email       = 'robert.dober@gmail.com'
  s.files       = Dir.glob("lib/**/*.rb")
  # s.files      += Dir.glob("bin/**/*")
  s.bindir      = "bin"
  s.files      += %w{LICENSE README.md}
  s.executables = Dir.glob("bin/*")
  s.homepage    = "https://github.com/RobertDober/lab42_tmux"
  s.licenses    = %w{MIT}

  s.required_ruby_version = '>= 2.0.0'
  s.add_dependency 'lab42_options', '~> 0.1.0'
  s.add_dependency 'forwarder19', '~> 0.2.0'

  s.add_development_dependency 'pry', '~> 0.9.12'
  s.add_development_dependency 'cucumber', '~> 1.3.2'
  s.add_development_dependency 'rspec', '~> 2.13.0'
  s.add_development_dependency 'aruba', '~> 0.5.3'
end

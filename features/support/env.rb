require 'aruba/cucumber'
require 'cucumber/rspec/doubles'

PROJECT_ROOT = File.expand_path "../../..", __FILE__

Before do
  # require 'pry'
  # binding.pry
  # Replace tmux with the mocked tmux
  ENV["PATH"] = "#{File.join(PROJECT_ROOT,"fixes")}:#{ENV["PATH"]}"
  # Use this version of the library
  ENV["RUBYLIB"] = File.join PROJECT_ROOT, "lib"
  # U probably want to half that unless U have an old Celeron box like me
  @aruba_timeout_seconds = 20
  # Close all open "sessions"
  # require 'pry'
  # binding.pry
  system "rm #{File.join PROJECT_ROOT, "fixes", "*.session"} 2>/dev/null || true"
  # require 'pry'
  # binding.pry
end

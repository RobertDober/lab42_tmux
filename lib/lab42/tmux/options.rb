require 'ostruct'
require 'lab42/tmux/options/api'
include Lab42::Tmux::Options::Api

@options = {}
@options["dir"] = ARGV.first
e = ARGV[1..-1]
e = (e || []).enum_for(:each)
loop do
  case current = e.next
  when /\A:(\w+)/
    @options[$1] = true
  when /(\w+):/
    @options[$1] = e.next
  else
    raise ArgumentError, ele
  end
end

@options = OpenStruct.new @options
@options.session_name ||= @options.dir && File.basename( @options.dir )
@options.tmux_source_file ||= "~/.tmux.conf"

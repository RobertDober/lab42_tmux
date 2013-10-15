class File
  class << self
    # TODO: Get rid of this and use expand_path
    alias_method :__orig_absolute_path__, :absolute_path
    def absolute_path fn
      if %r{\A~} === fn && home = ENV["HOME"]
        File.join home, fn.sub(%r{\A~#{File::Separator}},"")
      else
        __orig_absolute_path__ fn
      end
    end
  end

  module YAML extend self
    def exists? fn
      f = fn.sub %r{(?<=\.)[^.]*\z}, ""
      check_for = -> fn do
        File.readable?( fn ) && fn
      end
      if f != fn
        check_for.( fn )
      else
        %w{yaml yml}.inject false do |fnorf, ext|
          fnorf || check_for.( "#{f}.#{ext}" )
        end
      end
    end
  end
end

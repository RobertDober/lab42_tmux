class File
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

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
    def exists? fn, search_path: []
      exists_as_specified?( fn ) ||
        exists_in_search_path?( fn, search_path: search_path )
    end

    def exists_as_specified? fn
      # remove extension without preceding .
      f = fn.sub %r{(?<=\.)[^.]*\z}, ""
      if f != fn
        check_for( fn )
      else
        %w{yaml yml}.inject false do |fnorf, ext|
          fnorf || check_for( "#{f}.#{ext}" )
        end 
      end
    end

    def exists_in_search_path? fn, search_path: required
      # remove extension without preceding .
      f = fn.sub %r{(?<=\.)[^.]*\z}, ""
      if f != fn
        Array( search_path ).inject false do |false_or_file, sp|
          false_or_file || check_for( File.join(sp, fn) )
        end
      else
        Array( search_path ).inject false do |false_or_file, sp|
          false_or_file or %w{yaml yml}.inject false do |fnorf, ext|
            fnorf ||
              check_for( File.join(sp, "#{f}.#{ext}") )
          end
        end
      end
    end

    private
    # Maybe rename to file_exists_and_name ???
    def check_for fn
      File.readable?( fn ) && fn
    end
  end
end

module Enumerable
  alias_method :__original_map__, :map
  def map behavior=nil,&blk
    __original_map__(&(behavior||blk))
  end
end

class Array
  alias_method :__original_map__, :map
  def map behavior=nil,&blk
    __original_map__(&(behavior||blk))
  end
end 

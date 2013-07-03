
class Object
  def instance_eval_or_call blk
    if blk.arity.zero?
      instance_eval( &blk )
    else
      blk.( self )
    end
  end
end # class Object

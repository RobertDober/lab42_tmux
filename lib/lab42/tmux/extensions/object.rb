# Replace by lab42_core ASAP
#
class Object
  def with_present attribute, &blk
    val = send attribute
    return nil unless val
    blk.( val )
  rescue NoMethodError
  end

  # TODO: This shall go into lab42_core
  def fn
    return @__fn__ if @__fn__
    myself = self
    @__fn__ = BasicObject.new
    class << @__fn__; self end
    .module_eval do
      alias_method :__original_method_missing__, :method_missing
      define_method :method_missing do |*args,&blk|
        super unless blk.nil? && args.size == 1
        # TODO: Catch error and call origianl method for better Error Messages
        myself.method args.first.to_sym
      end
    end
  end
end

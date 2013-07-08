# Replace by lab42_core ASAP
#
class Object
  def with_present attribute, &blk
    val = send attribute
    return nil unless val
    blk.( val )
  rescue NoMethodError
  end
end

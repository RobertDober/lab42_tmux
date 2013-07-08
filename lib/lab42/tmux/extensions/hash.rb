# Replace by lab42_core ASAP
#
class Hash
  def with_present key, &blk
    return nil unless has_key? key
    blk.( fetch key )
  end
end

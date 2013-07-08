require 'forwarder'
class OpenStruct
  extend Forwarder
  forward :fetch, to: :to_h
end

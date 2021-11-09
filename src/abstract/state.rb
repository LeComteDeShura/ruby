require_relative './context'

class State
  attr_accessor :context

  def do
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end

  def next
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end
end

require_relative '../abstract/state'
# require './converter'
# require '../abstract/context'

class EndState < State
  def do
    exit 0
  end

  def next; end
end

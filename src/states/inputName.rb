require_relative '../abstract/state'
require_relative './converter'
require_relative './outputSimularName'
# require '../abstract/context'

class InputName < State
  def initialize
    @a = ''
  end

  def do
    @a = STDIN.getch
    @context.coin(@a)
  end

  def next
    # puts "asdasd"
    exit 0 if @a == "\e"

    if @a == "\r"
      @context.transition_to(SetFirstCoin.new)
    else
      @context.transition_to(OutputSimularNames.new)
    end
  end
end

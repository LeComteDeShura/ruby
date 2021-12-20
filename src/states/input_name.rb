require_relative '../abstract/state'
require_relative './converter'
require_relative './output'
require_relative './set_coin'
require_relative './exit'
# require '../abstract/context'

class InputName < State
  def do
    pointer = 15 + @context.current_coin.size
    print "\e[2;#{pointer}H"
    @key = $stdin.getch
    @context.add_key_to_coin(@key)
  end

  def next
    case @key
    when "\e"
      @context.transition_to(Exit.new)
    when "\r"
      @context.transition_to(SetCoin.new)
      @context.transition_to(Output.new) if @context.current_coin.empty?
    else
      @context.transition_to(Output.new)
    end
  end
end

require_relative '../abstract/state'
require_relative './converter'
require_relative './output_simular_name'
# require '../abstract/context'

class InputName < State
  def initialize
    super()
    @a = ''
  end

  def do
    @a = $stdin.getch
    @context.gcoin(@a)
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

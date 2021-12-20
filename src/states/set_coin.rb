require_relative '../abstract/state'
require_relative './converter'
require_relative './is_right_name'
require_relative './input_value'
# require '../abstract/context'

class SetCoin < State
  def do
    @flag = false
    @flag = true if @context.current_coin != @context.similar_names[0] && @context.current_coin != ''
  end

  def set_from_coin
    @context.from_coin = @context.current_coin
    @context.current_coin = ''
  end

  def set_to_coin
    @context.to_coin = @context.current_coin
    @context.current_coin = ''
  end

  def next
    if @flag
      @context.transition_to IsRightName.new
    elsif @context.from_coin == ''
      set_from_coin
      @context.transition_to Output.new
    else
      set_to_coin
      @context.transition_to InputValue.new
    end
  end
end

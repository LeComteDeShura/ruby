require_relative '../abstract/state'
require_relative './converter'
require_relative './is_right_name'
require_relative './input_name'
require_relative './input_value'

class SetSecondCoin < State
  def do; end

  def next
    if @context.coin.empty? && (@context.coins.size == 1)
      @context.transition_to(InputName.new)
    elsif (@context.coin != @context.similarNames[0]) && (@context.coins.size == 1)
      @context.transition_to(IsRightName.new)
    else
      @context.coins.push @context.coin
      @context.transition_to(InputValue.new)
    end
  end
end

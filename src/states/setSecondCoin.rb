require_relative '../abstract/state'
require_relative './converter'
require_relative './isRightName'
require_relative './inputName'
require_relative './inputValue'

class SetSecondCoin < State
  def do; end

  def next
    if @context.coin.empty? and @context.coins.size == 1
      @context.transition_to(InputName.new)
    elsif @context.coin != @context.similarNames[0] and @context.coins.size == 1
      @context.transition_to(IsRightName.new)
    else
      @context.coins.push @context.coin
      @context.transition_to(InputValue.new)
    end
  end
end

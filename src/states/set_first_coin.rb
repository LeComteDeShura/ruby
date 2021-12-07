require_relative '../abstract/state'
require_relative './converter'
require_relative './set_second_coin'
require_relative './is_right_name'
require_relative './input_name'
# require '../abstract/context'

class SetFirstCoin < State
  def do; end

  def next
    if @context.coins.empty?
      if !@context.coin.empty?
        if @context.coin != @context.similarNames[0]
          @context.transition_to(IsRightName.new)
          @context.coin = ''
        else
          @context.coins.push @context.coin
          @context.coin = ''
          @context.transition_to(SetSecondCoin.new)
        end
      else
        @context.transition_to(InputName.new)
      end
    else
      @context.transition_to(SetSecondCoin.new)
    end
  end
end

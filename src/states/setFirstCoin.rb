require_relative '../abstract/state'
require_relative './converter'
require_relative './setSecondCoin'
require_relative './isRightName'
require_relative './inputName'
# require '../abstract/context'

class SetFirstCoin < State
    def do; end

    def next
        if @context.coins.empty? then
            if not @context.coin.empty? then
                if @context.coin != @context.similarNames[0] then
                    @context.transition_to(IsRightName.new)
                    @context.coin = ""
                else
                    @context.coins.push @context.coin
                    @context.coin = ""
                    @context.transition_to(SetSecondCoin.new)
                end
            else
                @context.transition_to(InputName.new)
            end
            # puts @context.coin
        else
            @context.transition_to(SetSecondCoin.new)
        end

        # exit 0
    end
end

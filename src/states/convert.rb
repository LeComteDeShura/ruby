require_relative '../abstract/state'
require_relative './converter'
# require '../abstract/context'

class Convert < State
  def do
    rate1 = @context.getCurrentRate(@context.coins[0])
    rate2 = @context.getCurrentRate(@context.coins[1])

    converted = @context.convert(rate1, rate2, @context.value)
    puts "Converted #{@context.value} #{@context.coins[0]} = #{converted} #{@context.coins[1]}"
  end

  def next
    # @context.transition_to(InputValue.new)
    exit 0
  end
end

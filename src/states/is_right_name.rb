require_relative '../abstract/state'
require_relative './converter'
require_relative './set_first_coin'
# require '../abstract/context'

class IsRightName < State
  def do
    puts "Do you mean #{@context.similarNames[0]}?"
    loop do
      @yn = $stdin.getch
      break if @context.isYorN? @yn
    end
  end

  def next
    system 'clear'
    puts 'Input ticker: '
    @context.coins.push @context.similarNames[0] if @yn == 'y'
    @context.coin = ''
    @context.transition_to(SetFirstCoin.new)
  end
end

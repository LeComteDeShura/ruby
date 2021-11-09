require_relative '../abstract/state'
require_relative './converter'
require_relative './setFirstCoin'
# require '../abstract/context'

class IsRightName < State
  def do
    puts 'Do you mean ' + @context.similarNames[0] + '?'
    loop do
      @yn = STDIN.getch
      break if @context.isYorN? @yn
    end
  end

  def next
    system 'clear'
    puts 'Input ticker: '
    if @yn == 'y'
      @context.coins.push @context.similarNames[0]
      @context.coin = ''
      @context.transition_to(SetFirstCoin.new)
    else
      @context.coin = ''
      @context.transition_to(SetFirstCoin.new)
    end
  end
end

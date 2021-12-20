require_relative '../abstract/state'
require_relative './converter'
require_relative './set_coin'
# require '../abstract/context'

class IsRightName < State
  def y_or_n?(key)
    return false unless key[/[y|n]/]

    true
  end

  def do
    system 'clear'
    print "Do you mean #{@context.similar_names[0]}? (y/n) "
    loop do
      @key = $stdin.getch
      break if y_or_n? @key

      puts @key
    end
    if @key == 'y'
      @context.current_coin = @context.similar_names[0]
    else
      @context.current_coin = ''
      @context.similar_names = []
    end
  end

  def next
    @context.transition_to SetCoin.new
  end
end

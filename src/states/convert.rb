require_relative '../abstract/state'
require_relative './converter'
require_relative './output'
# require '../abstract/context'

class Convert < State
  def convert
    return 0 if @context.from_coin.empty?

    rate1 = @context.get_current_rate(@context.from_coin)
    rate2 = @context.get_current_rate(@context.to_coin)
    @converted = ((rate1 / rate2) * @context.value).round(2)
  end

  def print_top
    puts "Converted #{@context.value} #{@context.from_coin} = #{@converted} #{@context.to_coin}"
  end

  def print_bottom
    print "\npress enter to continue\n"
    print "press q to exit\n"
  end

  def do
    convert
    print_top
    print_bottom

    @key = $stdin.getch while @key != 'q' && @key != "\r"
    @context.from_coin = ''
    @context.to_coin = ''
    @context.current_coin = ''
    @context.similar_names = []
  end

  def next
    if @key == 'q'
      @context.transition_to Exit.new
    else
      @context.transition_to Output.new
    end
  end
end

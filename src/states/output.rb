require_relative '../abstract/state'
require_relative './converter'
require_relative './input_name'
# require '../abstract/context'

class Output < State
  def print_top
    if @context.from_coin == ''
      print "convert from #{@context.current_coin} "
    else
      print "convert from #{@context.from_coin} "
    end

    print "to #{@context.current_coin} " if @context.from_coin != ''
    print "\n"
  end

  def print_similar_names
    puts 'similar names: '
    index = 0
    similar_names = @context.find_similar_names
    similar_names.each do |item|
      index += 1
      print "#{index}) #{item}\n"
      break if index >= 10
    end
  end

  def print_main
    puts "Input ticker: #{@context.current_coin}\n\n"
  end

  def do
    system 'clear'
    print_top
    print_main
    print_similar_names
  end

  def next
    @context.transition_to(InputName.new)
  end
end

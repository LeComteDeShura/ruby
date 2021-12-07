require_relative '../abstract/state'
require_relative './converter'
require_relative './input_name'
# require '../abstract/context'

class OutputSimularNames < State
  def printSimilarNames
    index = 0
    @context.similarNames.each do |item|
      puts item
      index += 1
      break if index >= 10
    end
  end

  def do
    system 'clear'

    puts "Input ticker: #{@context.coin}"
    puts 'similar names: '
    @context.getSimilarNames
    printSimilarNames
  end

  def next
    @context.transition_to(InputName.new)
  end
end

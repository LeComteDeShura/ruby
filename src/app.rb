require_relative './states/converter'
require_relative './states/set_first_coin'

class App
  def run
    system 'clear'
    context = Converter.new(SetFirstCoin.new)
    context.readDataCoinsLists
    context.parseCoinsList
    loop do
      context.do
      context.next
    end
  end
end

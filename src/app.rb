require_relative './states/converter'
require_relative './states/output'

class App
  def run
    system 'clear'
    context = Converter.new(Output.new)
    context.read_data_coins_lists
    context.parse_coins_list
    until context.state.is_a? Exit
      context.do
      context.next
    end
  end
end

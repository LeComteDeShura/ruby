require_relative '../abstract/state'
require_relative './converter'
require_relative './convert'
# require '../abstract/context'

class InputValue < State
  def do
    system 'clear'
    print 'Enter amount to convert: '
    $stdout.flush
    @context.value = $stdin.gets.chomp
  end

  def next
    if @context.isNumber? @context.value
      @context.value = @context.value.to_f
      @context.transition_to(Convert.new)
    else
      @context.transition_to(InputValue.new)
    end
    # exit 0
  end
end

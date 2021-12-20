require_relative '../abstract/state'
require_relative './converter'
require_relative './convert'
# require '../abstract/context'

class InputValue < State
  def number?(value)
    value.to_f.to_s == value || value.to_i.to_s == value
  end

  def print_top
    print "convert from #{@context.from_coin} to #{@context.to_coin}\n"
  end

  def do
    system 'clear'
    print_top
    print 'Enter amount to convert: '
    # $stdout.flush
    @context.value = $stdin.gets.chomp
  end

  def next
    if number? @context.value
      @context.value = @context.value.to_f
      @context.transition_to Convert.new
    else
      @context.transition_to InputValue.new
    end
    # exit 0
  end
end

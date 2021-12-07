require_relative '../src/states/input_value'

describe InputValue do
  describe '#do' do
    context 'stdin.getch y' do
      it 'transition_to SetFirstCoin' do
        context = Converter.new(InputValue.new)
        $stdin.should_receive(:gets).and_return("123\r")
        expect(context.state.is_a?(InputValue)).to eq true
        context.do
        context.next
        expect(context.state.is_a?(Convert)).to eq true
      end
    end

    context 'stdin.getch n' do
      it 'transition_to SetFirstCoin' do
        context = Converter.new(InputValue.new)
        context.similarNames = []
        context.similarNames.push 'test'
        $stdin.should_receive(:gets).and_return('n')
        expect(context.state.is_a?(InputValue)).to eq true
        context.do
        context.next
        expect(context.state.is_a?(InputValue)).to eq true
      end
    end
  end
end

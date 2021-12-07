require_relative '../src/states/is_right_name'

describe IsRightName do
  describe '#do' do
    context 'stdin.getch y' do
      it 'transition_to SetFirstCoin' do
        context = Converter.new(IsRightName.new)
        context.similarNames = []
        context.similarNames.push 'test'
        $stdin.should_receive(:getch).and_return('y')
        expect(context.state.is_a?(IsRightName)).to eq true
        context.do
        context.next
        expect(context.state.is_a?(SetFirstCoin)).to eq true
      end
    end

    context 'stdin.getch n' do
      it 'transition_to SetFirstCoin' do
        context = Converter.new(IsRightName.new)
        context.similarNames = []
        context.similarNames.push 'test'
        $stdin.should_receive(:getch).and_return('n')
        expect(context.state.is_a?(IsRightName)).to eq true
        context.do
        context.next
        expect(context.state.is_a?(SetFirstCoin)).to eq true
      end
    end
  end
end

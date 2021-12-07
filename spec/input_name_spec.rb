require_relative '../src/states/input_name'
require_relative '../src/states/set_first_coin'

describe InputName do
  describe '#do' do
    context 'stdin.getch ' do
      it 'transition_to OutputSimularNames' do
        context = Converter.new(InputName.new)
        $stdin.should_receive(:getch).and_return(' ')
        expect(context.state.is_a?(InputName)).to eq true
        context.do
        context.next
        expect(context.state.is_a?(OutputSimularNames)).to eq true
      end
    end

    context "stdin.getch \r" do
      it 'transition_to SetFirstCoin' do
        context = Converter.new(InputName.new)
        $stdin.should_receive(:getch).and_return("\r")
        expect(context.state.is_a?(InputName)).to eq true
        context.do
        context.next
        expect(context.state.is_a?(SetFirstCoin)).to eq true
      end
    end
  end
end

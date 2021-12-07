require_relative '../src/states/is_right_name'

describe IsRightName do
  describe '#do' do
    context ' ' do
      it 'transition_to SetSecondCoin' do
        context = Converter.new(SetFirstCoin.new)
        expect(context.state.is_a?(SetFirstCoin)).to eq true
        context.coins.push 'test'
        context.coin = 'test'
        context.similarNames = []
        context.similarNames.push 'asd'
        context.next
        expect(context.state.is_a?(SetSecondCoin)).to eq true
      end
    end

    context ' ' do
      it 'transition_to IsRightName' do
        context = Converter.new(SetFirstCoin.new)
        expect(context.state.is_a?(SetFirstCoin)).to eq true
        context.coin = 'test'
        context.similarNames = []
        context.similarNames.push 'asd'
        context.next
        expect(context.state.is_a?(IsRightName)).to eq true
      end
    end

    context ' ' do
      it 'transition_to InputName' do
        context = Converter.new(SetFirstCoin.new)
        expect(context.state.is_a?(SetFirstCoin)).to eq true
        # context.coins.push 'test'
        # context.coin = 'test'
        context.similarNames = []
        context.similarNames.push 'asd'
        context.next
        expect(context.state.is_a?(InputName)).to eq true
      end
    end

    context ' ' do
      it 'transition_to SetSecondCoin' do
        context = Converter.new(SetFirstCoin.new)
        expect(context.state.is_a?(SetFirstCoin)).to eq true
        # context.coins.push 'test'
        context.coin = 'test'
        context.similarNames = []
        context.similarNames.push 'test'
        context.next
        expect(context.state.is_a?(SetSecondCoin)).to eq true
      end
    end
  end
end

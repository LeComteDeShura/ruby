require_relative '../src/states/set_second_coin'

describe SetSecondCoin do
  describe '#do' do
    context ' ' do
      it 'transition_to InputName' do
        context = Converter.new(SetSecondCoin.new)
        expect(context.state.is_a?(SetSecondCoin)).to eq true
        context.coins.push 'test'
        context.next
        expect(context.state.is_a?(InputName)).to eq true
      end
    end

    context ' ' do
      it 'transition_to IsRightName' do
        context = Converter.new(SetSecondCoin.new)
        expect(context.state.is_a?(SetSecondCoin)).to eq true
        context.coin = 'test'
        context.coins.push 'test'
        context.similarNames.push 'asd'
        context.next
        expect(context.state.is_a?(IsRightName)).to eq true
      end
    end

    context ' ' do
      it 'transition_to InputValue' do
        context = Converter.new(SetSecondCoin.new)
        expect(context.state.is_a?(SetSecondCoin)).to eq true
        context.coins.push 'test'
        context.coins.push 'test'
        context.coin = 'test'
        context.similarNames = []
        context.similarNames.push 'asd'
        context.next
        expect(context.state.is_a?(InputValue)).to eq true
      end
    end
  end
end

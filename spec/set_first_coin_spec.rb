require_relative '../src/states/is_right_name'
require_relative '../src/states/set_coin'

describe SetCoin do
  describe '#next' do
    context 'when user input does not match the list' do
      let(:context) { Converter.new SetCoin.new }

      before do
        context.current_coin = 'test'
        context.similar_names.push 'test1'
        context.do
        context.next
      end

      subject { context.state }
      it { is_expected.to be_a IsRightName }
    end

    context 'when first coin was chosen' do
      let(:context) { Converter.new SetCoin.new }

      before do
        context.current_coin = 'test'
        context.similar_names.push 'test'
        context.do
        context.next
      end

      subject { context.state }
      it { is_expected.to be_a Output }
    end

    context 'when second coin was chosen' do
      let(:context) { Converter.new SetCoin.new }

      before do
        context.current_coin = 'test'
        context.from_coin = 'test'
        context.similar_names.push 'test'
        context.do
        context.next
      end

      subject { context.state }
      it { is_expected.to be_a InputValue }
    end
  end
end

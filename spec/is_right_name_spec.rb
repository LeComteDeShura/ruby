require_relative '../src/states/is_right_name'

describe IsRightName do
  describe '#next' do
    context 'when pressed \'y\'' do
      let(:context) { Converter.new IsRightName.new }
      let(:input) { StringIO.new('y') }

      before do
        $stdin = input
        context.do
        context.next
      end

      subject { context.state }
      it { is_expected.to be_a SetCoin }
    end

    context 'when pressed \'n\'' do
      let(:context) { Converter.new IsRightName.new }
      let(:input) { StringIO.new('n') }

      before do
        $stdin = input
        context.do
        context.next
      end

      subject { context.state }
      it { is_expected.to be_a SetCoin }
    end
  end
end

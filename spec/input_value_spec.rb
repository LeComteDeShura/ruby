require_relative '../src/states/input_value'

describe InputValue do
  describe '#next' do
    context 'when enter number' do
      let(:context) { Converter.new InputValue.new }
      let(:input) { StringIO.new("123\n") }

      before do
        $stdin = input
        context.do
        context.next
      end

      subject { context.state }
      it { is_expected.to be_a Convert }
    end

    context 'when enter not number' do
      let(:context) { Converter.new InputValue.new }
      let(:input) { StringIO.new("lol\n") }

      before do
        $stdin = input
        context.do
        context.next
      end

      subject { context.state }
      it { is_expected.to be_a InputValue }
    end
  end
end

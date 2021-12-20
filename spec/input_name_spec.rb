require_relative '../src/states/input_name'
require_relative '../src/states/converter'

describe InputName do
  describe '#next' do
    context 'when pressed esc' do
      let(:context) { Converter.new InputName.new }
      let(:input) { StringIO.new("\e") }

      before do
        $stdin = input
        context.do
        context.next
      end

      subject { context.state }
      it { is_expected.to be_a Exit }
    end

    context 'when pressed enter' do
      let(:context) { Converter.new InputName.new }
      let(:input) { StringIO.new("\r") }

      before do
        $stdin = input
        context.do
        context.next
      end

      subject { context.state }
      it { is_expected.to be_a Output }
    end

    context 'when pressed b key' do
      let(:context) { Converter.new InputName.new }
      let(:input) { StringIO.new('b') }

      before do
        $stdin = input
        context.do
        context.next
      end

      subject { context.state }
      it { is_expected.to be_a Output }
    end
  end
end

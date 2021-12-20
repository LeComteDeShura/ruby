require_relative 'spec_helper'
require_relative '../src/states/convert'
require_relative '../src/states/converter'

describe Convert do
  let(:context) { Converter.new Convert.new }
  describe '#print_top' do
    before do
      context.from_coin = 'btc'
      context.to_coin = 'eth'
      context.value = 123
    end
    let(:expect_text) { "Converted 123 btc =  eth\n" }
    it { expect { context.state.print_top }.to output(expect_text).to_stdout }
  end

  describe '#next' do
    context 'when pressed q key' do
      let(:input) { StringIO.new('q') }

      before do
        $stdin = input
        context.do
        context.next
      end

      subject { context.state }
      it { is_expected.to be_a Exit }
    end

    context 'when pressed enter' do
      let(:input) { StringIO.new("\r") }

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

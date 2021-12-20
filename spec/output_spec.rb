require_relative '../src/states/output'

describe Output do
  describe '#do' do
    let(:context) { Converter.new Output.new }
    let(:expect_text) { "convert from  \nInput ticker: \n\nsimilar names: \n" }
    it { expect { context.state.do }.to output(expect_text).to_stdout }
  end

  describe '#next' do
    let(:context) { Converter.new Output.new }
    before { context.next }
    subject { context.state }
    it { is_expected.to be_a InputName }
    # it { expect {
    #   context.next
    #   context.state
    # }.to be_a InputName }
  end
end

require_relative '../src/states/output_simular_name'

describe OutputSimularNames do
  describe '#do' do
    context 'stdin.getch y' do
      it 'transition_to SetFirstCoin' do
        context = Converter.new(OutputSimularNames.new)
        expect(context.state.is_a?(OutputSimularNames)).to eq true
        context.do
        context.next
        expect(context.state.is_a?(InputName)).to eq true
      end
    end
  end
end

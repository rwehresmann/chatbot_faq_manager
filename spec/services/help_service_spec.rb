require_relative './../spec_helper.rb'

describe HelpService do
  describe '#call' do
    subject { HelpService.call() }
    
    it "shows the main commands" do
      is_expected.to match('help')
      is_expected.to match('Adicione ao Faq')
      is_expected.to match('Remova ID')
      is_expected.to match('O que você sabe sobre X')
      is_expected.to match('Pesquise a hashtag X')
      is_expected.to match('Perguntas e Respostas')
    end
  end
end

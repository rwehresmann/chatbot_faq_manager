require './spec/spec_helper.rb'

describe Utils do
  let(:object) { Object.new.extend(Utils) }

  describe '#split_tags' do
    context "when separated by spaces" do
      it { expect(object.split_tags("ruby linux")).to eq ["ruby", "linux"] }
    end

    context "when separated by commass" do
      it { expect(object.split_tags("ruby, linux")).to eq ["ruby", "linux"] }
    end
  end
end

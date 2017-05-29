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

  describe '#search_type' do
    it "returns always the last piece from a string separated by '_'" do
      ["faq_search_by_term, link_search_all"].each { |string|
        expect(object.search_type(string)).to eq string.split("_").last
      }
    end
  end
end

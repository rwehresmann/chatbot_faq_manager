require './spec/spec_helper.rb'

describe Link do
  describe "Validations" do
    let(:link) { create(:link, :with_tag) }

    it "is valid with valid attributes" do
      expect(link).to be_valid
    end

    it "is invalid with empty url" do
      link.url = ""

      expect(link).to_not be_valid
    end

    it "is invalid with empty description" do
      link.description = ""

      expect(link).to_not be_valid
    end

    it "is invalid with no tags associated" do
      link.tags.clear

      expect(link).to_not be_valid
    end
  end

  describe '#add_tag' do
    describe '#add_tag' do
      it "adds" do
        link = create(:link, :with_tag)
        link.add_tag(create(:tag))

        expect(link.tags.count).to eq 2
      end
    end
  end
end

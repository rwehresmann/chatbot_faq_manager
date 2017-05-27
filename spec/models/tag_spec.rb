require './spec/spec_helper.rb'

describe Tag do
  describe "Validations" do
    let(:tag) { build(:tag) }

    it "is valid with valid attributes" do
      expect(tag).to be_valid
    end

    it "is invalid with empty description" do
      tag.name = ""

      expect(tag).to_not be_valid
    end
  end

  describe '#should_be_destroyed?' do
    context "when have links associated" do
      it "returns false" do
        tag = create(:tag, :with_links)

        expect(tag.should_be_destroyed?).to be_falsey
      end
    end

    context "when have questions associated" do
      it "returns false" do
        tag = create(:tag, :with_questions)

        expect(tag.should_be_destroyed?).to be_falsey
      end
    end

    context "when haven't any link or question associated" do
      it { expect(create(:tag).should_be_destroyed?).to be_truthy }
    end
  end
end

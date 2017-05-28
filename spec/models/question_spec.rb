require './spec/spec_helper.rb'

describe Question do
  describe "Validations" do
    let(:question) { build(:question) }

    it "is valid with valid attributes" do
      expect(question).to be_valid
    end

    it "is invalid with empty description" do
      question.description = ""
      expect(question).to_not be_valid
    end
  end

  describe '#add_tag' do
    it "adds" do
      question = create(:question)
      question.add_tag(create(:tag))

      expect(question.tags.count).to eq 1
    end
  end

  describe '#add_answer' do
    it "adds" do
      question = create(:question)
      question.add_answer(create(:answer))

      expect(question.answers.count).to eq 1
    end
  end

  describe '#should_be_destroyed?' do
    context "with no answers" do
      it { expect(create(:question).should_be_destroyed?).to be_truthy }
    end

    context "with answers" do
      let(:question) { create(:question, :with_answer) }
      
      it { expect(question.should_be_destroyed?).to be_falsey }
    end
  end
end

require './spec/spec_helper.rb'

describe Answer do
  describe "Validations" do
    let(:answer) { build(:answer) }

    it "is valid with valid attributes" do
      expect(answer).to be_valid
    end

    it "is invalid when not associated to a question" do
      answer.question = nil

      expect(answer).to_not be_valid
    end
  end
end

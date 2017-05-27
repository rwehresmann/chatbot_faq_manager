require './spec/spec_helper.rb'

describe Faq::Creator do
  include Faq::Utils

  describe '#call' do
    context "without an answer" do
      subject { described_class.new(question: "question", tags: "tag").call }

      it "doesn't create the records" do
        does_not_create_records
        is_expected.to eq error_hash(:answer)
      end
    end

    context "without a question" do
      subject { described_class.new(answer: "answer", tags: "tag").call }

      it "doesn't create the records" do
        does_not_create_records
        is_expected.to eq error_hash(:question)
      end
    end

    context "without any tags" do
      subject { described_class.new(question: "question", answer: "answer").call }

      it "doesn't create the records" do
        does_not_create_records
        is_expected.to eq error_hash(:tags)
      end
    end

    context "with all params" do
      subject {
        described_class.new(
          question: "question",
          answer: "answer",
          tags: "tag1 tag2"
        ).call
      }

      it "creates the records" do
        questions_count = Question.count
        answers_count = Question.count
        tags_count = Question.count

        response = described_class.new(
          question: "question",
          answer: "answer",
          tags: "tag1 tag2"
        ).call

        expect(Question.count).to eq questions_count + 1
        expect(Answer.count).to eq answers_count + 1
        expect(Tag.count).to eq tags_count + 2
      end
    end
  end

  def does_not_create_records
    [Question, Answer, Tag].each { |model|
      expect { subject }.to_not change(model, :count)
    }
  end
end

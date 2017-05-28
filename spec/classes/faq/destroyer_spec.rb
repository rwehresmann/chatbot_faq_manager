require './spec/spec_helper.rb'

describe Faq::Destroyer do
  include Utils

  describe '#call' do
    context "when deleting a question" do
      context "that doesn't exists" do
        it "doesn't deletes nothing" do
          create(:question)
          create(:answer)
          create(:tag)

          counts = table_counts

          id = Question.last.id + 1
          response = described_class.new(id: id, target: :question).call

          expect(Question.count).to eq counts[:question]
          expect(Answer.count).to eq counts[:answer]
          expect(Tag.count).to eq counts[:tag]
          expect(response).to eq error_hash(:question)
        end
      end

      context "that exists" do
        context "with tags associated to another records" do
          it "deletes the question and answers associated but not the tags" do
            questions = create_pair(:question)
            answer = create(:answer, question: questions[0])
            tag = create(:tag)
            questions.each { |question| question.add_tag(tag) }

            counts = table_counts

            response = described_class.new(
              id: questions[0],
              target: :question
            ).call

            expect(Question.count).to eq counts[:question] - 1
            expect(Answer.count).to eq counts[:answer] - 1
            expect(Tag.count).to eq counts[:tag]
            expect(response).to eq success_hash
          end
        end

        context "with tags not associated to another records" do
          it "deltes the question, answers and tags associated" do
            question = create(:question)
            answer = create(:answer, question: question)
            tag = create(:tag)
            question.add_tag(tag)

            counts = table_counts

            response = described_class.new(
              id: question,
              target: :question
            ).call

            expect(Question.count).to eq counts[:question] - 1
            expect(Answer.count).to eq counts[:answer] - 1
            expect(Tag.count).to eq counts[:tag] - 1
            expect(response).to eq success_hash
          end
        end
      end
    end

    context "when deleting an answer" do
      context "that doesn't exists" do
        it "doesn't deletes nothing" do
          create(:question)
          create(:answer)
          create(:tag)

          counts = table_counts

          id = Answer.last.id + 1
          response = described_class.new(id: id, target: :answer).call

          expect(Question.count).to eq counts[:question]
          expect(Answer.count).to eq counts[:answer]
          expect(Tag.count).to eq counts[:tag]
          expect(response).to eq error_hash(:answer)
        end
      end

      context "that exists" do
        context "and is the only answer of the question" do
          it "deletes the answer and its question" do
            question = create(:question)
            answer = create(:answer, question: question)

            counts = table_counts

            response = described_class.new(id: answer, target: :answer).call

            expect(response).to eq success_hash
            expect(Answer.count).to eq counts[:answer] - 1
            expect(Question.count).to eq counts[:question] - 1
          end
        end

        context "and isn't the only answer of the question" do
          it "deletes only the answer" do
            question = create(:question, :with_answer)
            answer = create(:answer, question: question)

            counts = table_counts

            response = described_class.new(id: answer, target: :answer).call

            expect(response).to eq success_hash
            expect(Answer.count).to eq counts[:answer] - 1
            expect(Question.count).to eq counts[:question]
          end
        end
      end
    end
  end

  def table_counts
    {
      question: Question.count,
      answer: Answer.count,
      tag: Tag.count
    }
  end
end

require './spec/spec_helper.rb'

describe Faq::InterpreterService do
  include Faq::Utils

  describe '.call' do
    context "whit a search_all action" do
      subject { described_class.call("search_all", "query" => "something") }

      it "calls Faq::Searcher with the search: :all" do
        allow(Faq::Searcher).to receive(:new)
          .with(search: :all, query: String) { object_with_call_allowed }
        allow_any_instance_of(Faq::Message::Searcher).to receive(:show) { :ok }

        is_expected.to eq :ok
      end
    end

    context "whit a search_by_term action" do
      subject { described_class.call("search_by_term", "query" => "something") }

      it "calls Faq::Searcher with search: :term" do
        allow(Faq::Searcher).to receive(:new)
          .with(search: :term, query: String) { object_with_call_allowed }
        allow_any_instance_of(Faq::Message::Searcher).to receive(:show) { :ok }

        is_expected.to eq :ok
      end
    end

    context "whit a search_by_tag action" do
      subject { described_class.call("search_by_tag", "query" => "something") }

      it "calls Faq::Searcher with search: :tag" do
        allow(Faq::Searcher).to receive(:new)
          .with(search: :tag, query: String) { object_with_call_allowed }
        allow_any_instance_of(Faq::Message::Searcher).to receive(:show) { :ok }

        is_expected.to eq :ok
      end
    end

    context "whit a create_faq action" do
      subject {
        described_class.call(
          "create_faq",
          "question" => "question",
          "answer" => "answer",
          "tags" => "tags"
        )
      }

      it "calls Faq::Creater" do
        allow(Faq::Creater).to receive(:new)
          .with(
            question: String,
            answer: String,
            tags: String
          ) { object_with_call_allowed }
        allow_any_instance_of(Faq::Message::Creater).to receive(:show) { :ok }

        is_expected.to eq :ok
      end
    end

    context "whit a destroy_question action" do
      subject {
        described_class.call(
          "destroy_question",
          "id" => "1"
        )
      }

      it "calls Faq::Destroyer" do
        allow(Faq::Destroyer).to receive(:new)
          .with(
            id: String,
            target: "question"
          ) { object_with_call_allowed }
        allow_any_instance_of(Faq::Message::Destroyer).to receive(:show) { :ok }

        is_expected.to eq :ok
      end
    end

    context "whit a destroy_answer action" do
      subject {
        described_class.call(
          "destroy_answer",
          "id" => "1"
        )
      }

      it "calls Faq::Destroyer" do
        allow(Faq::Destroyer).to receive(:new)
          .with(
            id: String,
            target: "answer"
          ) { object_with_call_allowed }
        allow_any_instance_of(Faq::Message::Destroyer).to receive(:show) { :ok }

        is_expected.to eq :ok
      end
    end

    context "whit an unrouted action" do
      subject { described_class.call("something") }

      it "informs that the bot wasn't able to understand this action" do
        is_expected.to eq "I couldn't understand this action."
      end
    end
  end

  def object_with_call_allowed
    object = double("Searcher")
    allow(object).to receive(:call) { {} }
    object
  end

  def create_questions
    questions = [
      create(:question, description: "Why Ruby is so nice?"),
      create(:question, description: "Why should I use Linux?")
    ]
    questions.each { |question| create_pair(:answer, question: question) }
    create(:tag, questions: [questions[0]], name: "ruby")
    create(:tag, questions: [questions[1]], name: "linux")

    questions
  end
end

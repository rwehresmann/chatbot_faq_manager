require './spec/spec_helper.rb'

describe Interpreter do
  include Utils

  describe '.call' do
    context "whit a faq_search_all action" do
      subject { described_class.call("faq_search_all", "query" => "something") }

      it "calls Faq::Searcher with the search: :all" do
        allow(Faq::Searcher).to receive(:new)
          .with(search: :all, query: String) { object_with_call_allowed }
        allow_any_instance_of(Message::Faq::Searcher).to receive(:show) { :ok }

        is_expected.to eq :ok
      end
    end

    context "whit a faq_search_by_term action" do
      subject { described_class.call("faq_search_by_term", "query" => "something") }

      it "calls Faq::Searcher with search: :term" do
        allow(Faq::Searcher).to receive(:new)
          .with(search: :term, query: String) { object_with_call_allowed }
        allow_any_instance_of(Message::Faq::Searcher).to receive(:show) { :ok }

        is_expected.to eq :ok
      end
    end

    context "whit a faq_search_by_tag action" do
      subject { described_class.call("faq_search_by_tag", "query" => "something") }

      it "calls Faq::Searcher with search: :tag" do
        allow(Faq::Searcher).to receive(:new)
          .with(search: :tag, query: String) { object_with_call_allowed }
        allow_any_instance_of(Message::Faq::Searcher).to receive(:show) { :ok }

        is_expected.to eq :ok
      end
    end

    context "whit a faq_create action" do
      subject {
        described_class.call(
          "faq_create",
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
        allow_any_instance_of(Message::Faq::Creater).to receive(:show) { :ok }

        is_expected.to eq :ok
      end
    end

    context "whit a faq_destroy_question action" do
      subject {
        described_class.call(
          "faq_destroy_question",
          "id" => "1"
        )
      }

      it "calls Faq::Destroyer" do
        allow(Faq::Destroyer).to receive(:new)
          .with(
            id: String,
            target: "question"
          ) { object_with_call_allowed }
        allow_any_instance_of(Message::Faq::Destroyer).to receive(:show) { :ok }

        is_expected.to eq :ok
      end
    end

    context "whit a faq_destroy_answer action" do
      subject {
        described_class.call(
          "faq_destroy_answer",
          "id" => "1"
        )
      }

      it "calls Faq::Destroyer" do
        allow(Faq::Destroyer).to receive(:new)
          .with(
            id: String,
            target: "answer"
          ) { object_with_call_allowed }
        allow_any_instance_of(Message::Faq::Destroyer).to receive(:show) { :ok }

        is_expected.to eq :ok
      end
    end

    context "with a link_search_all action" do
      subject {
        described_class.call(
          "link_search_all",
          "query" => "something"
        )
      }

      it "calls LinkAgregator::Searcher with search: :all" do
        allow(LinkAgregator::Searcher).to receive(:new)
          .with(
            search: :all,
            query: String
          ) { object_with_call_allowed }
        allow_any_instance_of(
          Message::LinkAgregator::Searcher
        ).to receive(:show) { :ok }

        is_expected.to eq :ok
      end
    end

    context "with a link_search_by_term action" do
      subject {
        described_class.call(
          "link_search_by_term",
          "query" => "something"
        )
      }

      it "calls LinkAgregator::Searcher with search: :term" do
        allow(LinkAgregator::Searcher).to receive(:new)
          .with(
            search: :term,
            query: String
          ) { object_with_call_allowed }
        allow_any_instance_of(
          Message::LinkAgregator::Searcher
        ).to receive(:show) { :ok }

        is_expected.to eq :ok
      end
    end

    context "with a link_search_by_tag action" do
      subject {
        described_class.call(
          "link_search_by_tag",
          "query" => "something"
        )
      }

      it "calls LinkAgregator::Searcher with search: :tag" do
        allow(LinkAgregator::Searcher).to receive(:new)
          .with(
            search: :tag,
            query: String
          ) { object_with_call_allowed }
        allow_any_instance_of(
          Message::LinkAgregator::Searcher
        ).to receive(:show) { :ok }

        is_expected.to eq :ok
      end
    end

    context "with a link_destroy action" do
      subject {
        described_class.call(
          "link_destroy",
          "id" => "1"
        )
      }

      it "calls LinkAgregator::Destroyer" do
        allow(LinkAgregator::Destroyer).to receive(:new)
          .with(id: String) { object_with_call_allowed }
        allow_any_instance_of(
          Message::LinkAgregator::Destroyer
        ).to receive(:show) { :ok }

        is_expected.to eq :ok
      end
    end

    context "with a link_create action" do
      subject {
        described_class.call(
          "link_create",
          "url" => "www.something.com",
          "description" => "description",
          "tags" => "tag"
        )
      }

      it "calls LinkAgregator::Creater" do
        allow(LinkAgregator::Creater).to receive(:new)
          .with(
            url: String,
            description: String,
            tags: String
          ) { object_with_call_allowed }
        allow_any_instance_of(
          Message::LinkAgregator::Creater
        ).to receive(:show) { :ok }

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

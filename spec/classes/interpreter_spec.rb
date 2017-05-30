require './spec/spec_helper.rb'

describe Interpreter do
  include Utils

  describe '.call' do
    context "whit a faq_search_all action" do
      subject { described_class.call(:faq_search_all, {}) }

      it "calls Faq::Searcher with the search: :all" do
        allow(Faq::Searcher).to receive(:new)
          .with(Hash) { object_with_call_allowed }
        allow_any_instance_of(Message::Faq::Searcher).to receive(:show) { :ok }

        is_expected.to eq :ok
      end
    end

    context "whit a faq_search_by_term action" do
      subject { described_class.call(:faq_search_by_term, {}) }

      it "calls Faq::Searcher with search: :term" do
        allow(Faq::Searcher).to receive(:new)
          .with(Hash) { object_with_call_allowed }
        allow_any_instance_of(Message::Faq::Searcher).to receive(:show) { :ok }

        is_expected.to eq :ok
      end
    end

    context "whit a faq_search_by_tag action" do
      subject { described_class.call(:faq_search_by_tag, {}) }

      it "calls Faq::Searcher with search: :tag" do
        allow(Faq::Searcher).to receive(:new)
          .with(Hash) { object_with_call_allowed }
        allow_any_instance_of(Message::Faq::Searcher).to receive(:show) { :ok }

        is_expected.to eq :ok
      end
    end

    context "whit a faq_create action" do
      subject { described_class.call(:faq_create, {}) }

      it "calls Faq::Creater" do
        allow(Faq::Creater).to receive(:new)
          .with(Hash) { object_with_call_allowed }
        allow_any_instance_of(Message::Faq::Creater).to receive(:show) { :ok }

        is_expected.to eq :ok
      end
    end

    context "whit a faq_destroy_question action" do
      subject { described_class.call(:faq_destroy_question, {}) }

      it "calls Faq::Destroyer" do
        allow(Faq::Destroyer).to receive(:new)
          .with(Hash) { object_with_call_allowed }
        allow_any_instance_of(Message::Faq::Destroyer).to receive(:show) { :ok }

        is_expected.to eq :ok
      end
    end

    context "whit a faq_destroy_answer action" do
      subject { described_class.call(:faq_destroy_answer, {}) }

      it "calls Faq::Destroyer" do
        allow(Faq::Destroyer).to receive(:new)
          .with(Hash) { object_with_call_allowed }
        allow_any_instance_of(Message::Faq::Destroyer).to receive(:show) { :ok }

        is_expected.to eq :ok
      end
    end

    context "with a link_search_all action" do
      subject { described_class.call(:link_search_all, {}) }

      it "calls LinkAgregator::Searcher with search: :all" do
        allow(LinkAgregator::Searcher).to receive(:new)
          .with(Hash) { object_with_call_allowed }
        allow_any_instance_of(
          Message::LinkAgregator::Searcher
        ).to receive(:show) { :ok }

        is_expected.to eq :ok
      end
    end

    context "with a link_search_by_term action" do
      subject { described_class.call(:link_search_by_term, {}) }

      it "calls LinkAgregator::Searcher with search: :term" do
        allow(LinkAgregator::Searcher).to receive(:new)
          .with(Hash) { object_with_call_allowed }
        allow_any_instance_of(
          Message::LinkAgregator::Searcher
        ).to receive(:show) { :ok }

        is_expected.to eq :ok
      end
    end

    context "with a link_search_by_tag action" do
      subject { described_class.call(:link_search_by_tag, {}) }

      it "calls LinkAgregator::Searcher with search: :tag" do
        allow(LinkAgregator::Searcher).to receive(:new)
          .with(Hash) { object_with_call_allowed }
        allow_any_instance_of(
          Message::LinkAgregator::Searcher
        ).to receive(:show) { :ok }

        is_expected.to eq :ok
      end
    end

    context "with a link_destroy action" do
      subject { described_class.call(:link_destroy, {}) }

      it "calls LinkAgregator::Destroyer" do
        allow(LinkAgregator::Destroyer).to receive(:new)
          .with(Hash) { object_with_call_allowed }
        allow_any_instance_of(
          Message::LinkAgregator::Destroyer
        ).to receive(:show) { :ok }

        is_expected.to eq :ok
      end
    end

    context "with a link_create action" do
      subject { described_class.call(:link_create, {}) }

      it "calls LinkAgregator::Creater" do
        allow(LinkAgregator::Creater).to receive(:new)
          .with(Hash) { object_with_call_allowed }
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

    context "with a general_helper action" do
      subject { described_class.call(:general_helper) }

      it "calls Helper" do
        allow(Helper).to receive(:new) { object_with_call_allowed }
        allow_any_instance_of(
          Message::Helper
        ).to receive(:show) { :ok }

        is_expected.to eq :ok
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

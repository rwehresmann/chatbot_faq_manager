require './spec/spec_helper.rb'

describe Faq::Searcher do
  include Faq::Utils

  describe '#call' do
    context "when searching by term" do
      context "when none question is found" do
        subject { described_class.new(search: :term, query: "something").call }

        it "returns an empty result in success_hash" do
          is_expected.to eq success_hash(questions: [])
        end
      end

      context "when questions are found" do
        subject { described_class.new(search: :term, query: "nice ruby").call }

        it "returns these results in success_hash" do
          questions = create_pair(:question, description: "How nice is Ruby?")
          create(:question, description: "Why should I use Linux?")

          is_expected.to eq success_hash(questions: questions)
        end
      end
    end

    context "when searching by tags" do
      context "when none question is found" do
        subject { described_class.new(search: :tag, query: "something").call }

        it "returns an empty result in success_hash" do
          is_expected.to eq success_hash(questions: [])
        end
      end

      context "when questions are found" do
        subject { described_class.new(search: :tag, query: "ruby").call }

        it "returns these results in success_hash" do
          tag = create(:tag, name: "ruby")
          questions = create_pair(
            :question,
            description: "How nice is Ruby?",
            tags: [tag]
          )
          create(
            :question,
            description: "Why should I use Linux?",
            tags: [create(:tag, name: "linux")]
          )

          is_expected.to eq success_hash(questions: questions)
        end
      end
    end

    context "when searching for all" do
      subject { described_class.new(search: :all).call }

      context "when there are no questions" do
        it { is_expected.to eq success_hash(questions: []) }
      end

      context "when there are questions" do
        it "returns all in success_hash" do
          questions = create_pair(:question)

          is_expected.to eq success_hash(questions: questions)
        end
      end
    end

    context "when enter an invalid search action" do
      subject { described_class.new(search: :something, query: "ruby").call }

      it { is_expected.to eq error_hash(:search) }
    end
  end
end

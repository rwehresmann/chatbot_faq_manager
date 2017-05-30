require './spec/spec_helper.rb'

describe LinkAgregator::Searcher do
  include Utils

  describe '#call' do
    context "when searching by term" do
      context "when none link is found" do
        subject { described_class.new(search: "term", query: "something").call }

        it "returns an empty result in success_hash" do
          is_expected.to eq success_hash(links: [])
        end
      end

      context "when links are found" do
        subject { described_class.new(search: "term", query: "nice ruby").call }

        it "returns these results in success_hash" do
          links = create_pair(
            :link,
            :with_tag,
            description: "Nice link about ruby gems."
          )
          create(:link, :with_tag, description: "Linux Github repo.")

          is_expected.to eq success_hash(links: links)
        end
      end
    end

    context "when searching by tag" do
      context "when none link is found" do
        subject { described_class.new(search: "tag", query: "something").call }

        it { is_expected.to eq success_hash(links: []) }
      end

      context "when links are found" do
        subject { described_class.new(search: "tag", query: "ruby").call }

        it "returns these results in success_hash" do
          tag = create(:tag, name: "ruby")
          links = create_pair(
            :link,
            description: "Nice site to check popularity of gems.",
            url: "https://www.ruby-toolbox.com/",
            tags: [tag]
          )
          create(
            :link,
            description: "Linux Github repo.",
            url: "https://github.com/torvalds/linux",
            tags: [create(:tag, name: "linux")]
          )

          is_expected.to eq success_hash(links: links)
        end
      end
    end

    context "when searching for all" do
      subject { described_class.new(search: "all").call }

      context "when there aren't links" do
        it { is_expected.to eq success_hash(links: []) }
      end

      context "when there are links" do
        it "returns all in success_hash" do
          links = create_pair(:link, :with_tag)

          is_expected.to eq success_hash(links: links)
        end
      end
    end

    context "when enter an invalid search action" do
      subject { described_class.new(search: :something, query: "ruby").call }

      it { is_expected.to eq error_hash(:search) }
    end
  end
end

require './spec/spec_helper.rb'

describe LinkAgregator::Creater do
  include Utils

  describe '#call' do
    context "without an url" do
      it "doesn't create the records" do
        counts = table_counts

        response = described_class.new(
          description: "description",
          tags: "tag"
        ).call

        expect(Link.count).to eq counts[:link]
        expect(Tag.count).to eq counts[:tag]
        expect(response).to eq error_hash(:url)
      end
    end

    context "without a description" do
      it "doesn't create the records" do
        counts = table_counts

        response = described_class.new(
          url: "www.something.com",
          tags: "tag"
        ).call

        expect(Link.count).to eq counts[:link]
        expect(Tag.count).to eq counts[:tag]
        expect(response).to eq error_hash(:description)
      end
    end

    context "without any tag" do
      it "doesn't create the records" do
        counts = table_counts

        response = described_class.new(
          url: "www.something.com",
          description: "description",
        ).call

        expect(Link.count).to eq counts[:link]
        expect(Tag.count).to eq counts[:tag]
        expect(response).to eq error_hash(:tags)
      end
    end

    context "with all params" do
      it "creates the records" do
        counts = table_counts

        response = described_class.new(
          url: "www.something.com",
          description: "description",
          tags: "tag1 tag2"
        ).call

        expect(Link.count).to eq counts[:link] + 1
        expect(Tag.count).to eq counts[:tag] + 2
        expect(response).to eq success_hash
      end
    end
  end

  def table_counts
    {
      link: Link.count,
      tag: Tag.count
    }
  end
end

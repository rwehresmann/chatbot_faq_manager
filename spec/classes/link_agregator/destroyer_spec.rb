require './spec/spec_helper.rb'

describe LinkAgregator::Destroyer do
  include Utils

  describe '#call' do
    context "when deleting a link" do
      context "that doesn't exists" do
        it "doesn't deletes nothing" do
          create(:link, :with_tag)

          counts = table_counts

          id = Link.last.id + 1
          response = described_class.new(id: id).call

          expect(Link.count).to eq counts[:link]
          expect(Tag.count).to eq counts[:tag]
          expect(response).to eq error_hash(:link)
        end
      end

      context "that exists" do
        context "with tags associated to another records" do
          it "deletes only the link" do
            links = create_pair(:link, tags: [create(:tag)])

            counts = table_counts

            response = described_class.new(id: links[0]).call

            expect(Link.count).to eq counts[:link] - 1
            expect(Tag.count).to eq counts[:tag]
            expect(response).to eq success_hash
          end
        end

        context "with tags not associated to another records" do
          it "deltes the question, answers and tags associated" do
            link = create(:link, tags: [create(:tag)])
            create(:link, tags: [create(:tag)])

            counts = table_counts

            response = described_class.new(id: link).call

            expect(Link.count).to eq counts[:link] - 1
            expect(Tag.count).to eq counts[:tag] - 1
            expect(response).to eq success_hash
          end
        end
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

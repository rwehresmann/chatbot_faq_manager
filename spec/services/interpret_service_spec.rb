require_relative './../spec_helper.rb'

describe InterpretService do
  context 'when listing' do
    subject { InterpretService.call('list') }

    context "with zero faqs" do
      it "returns the doesn't found message" do
        create(:company)

        is_expected.to match "Nada encontrado"
      end
    end

    context "with two faqs" do
      it "shows the questions and their answers" do
        company = create(:company)
        faqs = create_pair(:faq, company: company)

        is_expected.to match faqs[0].question
        is_expected.to match faqs[0].answer
        is_expected.to match faqs[1].question
        is_expected.to match faqs[1].answer
      end
    end
  end

  context 'when doing a normal search' do
    context "with an empty (invalid) query" do
      subject { InterpretService.call('search') }

      it { is_expected.to match "Nada encontrado" }
    end

    context "with a valid query" do
      it "shows the questions and their answers who match with the query" do
        faqs = create_pair(:faq, company: create(:company))

        response = InterpretService.call(
          "search",
          { "query" => faqs[0].question.split(" ").sample }
        )

        faqs.each do |faq|
          expect(response).to match(faq.question)
          expect(response).to match(faq.answer)
        end
      end
    end
  end

  context 'when searching by hashtag' do
    context "with a hashtag who doesn't exists" do
      subject { InterpretService.call("search_by_hashtag") }

      it "shows the 'doesn't found' message" do
        create(:company)
        is_expected.to match "Nada encontrado"
      end
    end

    context "with a hashtag who exists" do
      it "shows the questions and their answers, associated to the query" do
        company = create(:company)
        faq = create(:faq, company: company)
        hashtag = create(:hashtag, company: company)
        create(:faq_hashtag, faq: faq, hashtag: hashtag)

        response = InterpretService.call(
          "search_by_hashtag",
          { "query" => hashtag.name }
        )

        expect(response).to match(faq.question)
        expect(response).to match(faq.answer)
      end
    end
  end

  context "whej creating a faq" do
    context "without hashtags" do
      subject {
        InterpretService.call(
          "create",
          { "question" => "question", "answer" => "answer", "hashtags" => ""}
        )
      }

      it "shows a required message" do
        expect { subject }.to_not change(Faq, :count)
        is_expected.to match "Hashtag Obrigatória"
      end
    end

    context "when informed all params" do
      subject {
        InterpretService.call(
          "create",
          {
            "question" => "quetsion",
            "answer" => "answer",
            "hashtags" => "ht1 ht2"
          }
        )
      }

      it "shows the right messages and create the faq" do
        faq_count = Faq.count
        hashtag_count = Hashtag.count

        is_expected.to match "Criado com sucesso"

        expect(Faq.count).to eq faq_count + 1
        expect(Hashtag.count).to eq hashtag_count + 2
      end
    end
  end

  context "when removing a faq" do
    context "with existing id" do
      it "deletes successfully and display a message informing that" do
        faq = create(:faq, company: create(:company))
        faq_count = Faq.count

        response = InterpretService.call("remove", { "id" => faq.id })

        expect(Faq.count).to eq faq_count - 1
        expect(response).to match("Deletado com sucesso")
      end
    end

    context "with nonexistent id" do
      subject do
        create(:company)
        InterpretService.call('remove', {"id" => 1})
      end

      it "doesn't deltes nothing and display an error message" do
        is_expected.to match "Questão inválida, verifique o Id"
      end
    end
  end
end

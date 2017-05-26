module FaqModule
  class ListService
    def initialize(action, params = {})
      # TODO: identify origin and set company
      @company = Company.last
      @action = action
      @query = params["query"]
    end

    def call
      if @action == "search"
        faqs = Faq.search(@query).where(company: @company)
      elsif @action == "search_by_hashtag"
        faqs = []
        @company.faqs.each { |faq|
          faq.hashtags.each { |hashtag| faqs << faq if hashtag.name == @query }
        }
      else
        faqs = @company.faqs
      end

      response = "*Perguntas e Respostas* \n\n"
      faqs.each do |f|
        response += "*#{f.id}* - "
        response += "*#{f.question}*\n"
        response += ">#{f.answer}\n"
        f.hashtags.each do |h|
          response += "_##{h.name}_ "
        end
        response += "\n\n"
      end
      (faqs.count > 0)? response : "Nada encontrado"
    end
  end
end

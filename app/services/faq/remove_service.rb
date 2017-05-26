module FaqModule
  class RemoveService
    def initialize(params)
      # TODO: identify origin and set company
      @company = Company.last
      @params = params
      @id = params["id"]
    end

    def call
      faq = @company.faqs.where(id: @id).last
      return "Questão inválida, verifique o Id" if faq == nil
      faq.hashtags.each { |hashtag| hashtag.delete if hashtag.faqs.count <= 1 }
      faq.delete

      "Deletado com sucesso"
    end
  end
end

module Faq
  class InterpreterService
    SEARCH = {
      "search_all" => :all,
      "search_by_term" => :term,
      "search_by_tag" => :tag
    }

    ACTION_MESSAGE = {
      "search_all" => :Searcher,
      "search_by_term" => :Searcher,
      "search_by_tag" => :Searcher,
      "create_faq" => :Creater,
      "destroy_faq" => :Destroyer
    }

    def self.call(action, args = {})
      response = case action
        when "search_all", "search_by_term", "search_by_tag"
          Faq::Searcher.new(
            search: SEARCH[action],
            query: args["query"]
          ).call
        when "create_faq"
          response = Faq::Creater.new(
            question: args["question"],
            answer: args["answer"],
            tags: args["tags"]
          ).call
        when "destroy_faq"
          response = Faq::Destroyer.new(
            id: args["id"],
            target: args["target"]
          ).call
        else
          return "I couldn't understand this action."
        end

      "Faq::Message::#{ACTION_MESSAGE[action]}"
        .safe_constantize
        .new(response)
        .show
    end
  end
end

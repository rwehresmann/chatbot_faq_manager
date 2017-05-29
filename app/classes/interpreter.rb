class Interpreter
  extend Utils

  SEARCH = {
    "faq_search_all" => :all,
    "faq_search_by_term" => :term,
    "faq_search_by_tag" => :tag,
    "link_search_all" => :all,
    "link_search_by_term" => :term,
    "link_search_by_tag" => :tag
  }

  MESSAGE = {
    "faq_search_all" => Message::Faq::Searcher,
    "faq_search_by_term" => Message::Faq::Searcher,
    "faq_search_by_tag" => Message::Faq::Searcher,
    "faq_create" => Message::Faq::Creater,
    "faq_destroy_question" => Message::Faq::Destroyer,
    "faq_destroy_answer" => Message::Faq::Destroyer,
    "link_search_all" => Message::LinkAgregator::Searcher,
    "link_search_by_term" => Message::LinkAgregator::Searcher,
    "link_search_by_tag" => Message::LinkAgregator::Searcher,
    "link_create" => Message::LinkAgregator::Creater,
    "link_destroy" => Message::LinkAgregator::Destroyer,
  }

  def self.call(action, args = {})
    response = case action
    when "faq_search_all", "faq_search_by_term", "faq_search_by_tag"
      Faq::Searcher.new(
        search: SEARCH[action],
        query: args["query"]
      ).call
    when "link_search_all", "link_search_by_term", "link_search_by_tag"
      LinkAgregator::Searcher.new(
        search: SEARCH[action],
        query: args["query"]
      ).call
    when "faq_create"
      response = Faq::Creater.new(
        question: args["question"],
        answer: args["answer"],
        tags: args["tags"]
      ).call
    when "link_create"
      response = LinkAgregator::Creater.new(
        description: args["description"],
        url: args["url"],
        tags: args["tags"]
      ).call
    when "faq_destroy_question", "faq_destroy_answer"
      response = Faq::Destroyer.new(
        id: args["id"],
        target: search_type(action)
      ).call
    when "link_destroy"
      response = LinkAgregator::Destroyer.new(id: args["id"]).call
    else
      return "I couldn't understand this action."
    end

    MESSAGE[action].new(response).show
  end
end

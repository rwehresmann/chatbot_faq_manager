module Faq
  class Searcher
    include Utils

    def initialize(args = {})
      @search = args[:search]
      @query = args[:query]
    end

    def call
      case @search
      when :term
        questions = Question.search(@query)
      when :tag
        tags = split_tags(@query)
        questions = QuestionByTagQuery.new.call(tags)
      when :all
        questions = Question.all
      else
        return error_hash(:search)
      end

      success_hash(questions: questions)
    end
  end
end

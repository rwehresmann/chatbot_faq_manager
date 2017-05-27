module Faq
  class Destroyer
    include Faq::Utils

    def initialize(args = {})
      @id = args[:id]
      @target = args[:target]
    end

    def call
      send("#{@target}_destroy_process")
    end

    private

    def question_destroy_process
      question = Question.find_by(id: @id)
      return error_hash(:question) if question.nil?

      tags = question.tags.to_a

      question.destroy
      tags.each { |tag| tag.destroy if tag.should_be_destroyed? }

      success_hash
    end

    def answer_destroy_process
      answer = Answer.find_by(id: @id)
      return error_hash(:answer) if answer.nil?

      question = answer.question

      answer.destroy
      question.destroy if question.should_be_destroyed?

      success_hash
    end
  end
end

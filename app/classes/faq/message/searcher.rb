module Faq
  module Message

    class Searcher
      def initialize(args)
        @success = args[:success]
        @info = args[:info]
      end

      def show
        if @success
          success_message
        else
          error_message
        end
      end

      private

      def success_message
        message =  "Check what I found in our *FAQ*:\n\n"

        @info[:questions].each do |question|
          message += "*#{question.id} - #{question.description}\n"
          question.answers.each { |answer|
            message += "> #{answer.id} - #{answer.content}\n"
          }
          question.tags.each { |tag| message += "_##{tag}_ "}
        end

        message
      end

      def error_message
        case @info[:error]
        when :search
          "Sorry, I couldn't understand what you want to search."
        else
          "Something wrong happened."
        end
      end
    end

  end
end

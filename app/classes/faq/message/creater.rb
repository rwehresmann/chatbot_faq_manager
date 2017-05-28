module Faq
  module Message

    class Creater
      def initialize(args)
        @success = args[:success]
        @info = args[:info]
      end

      def show
        if @success
          "Done! Question added to FAQ."
        else
          case @info[:error]
          when :question
            "Action canceled! It's necessary to describe te question."
          when :answer
            "Action canceled! It's necessary to describe te answer of the question."
          when :tags
            "Action canceled! You need to provide at least one tag to the question."
          end
        end
      end
    end

  end
end

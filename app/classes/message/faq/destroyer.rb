module Message
  module Faq

    class Destroyer
      def initialize(args)
        @success = args[:success]
        @info = args[:info]
      end

      def show
        if @success
          "Done! Question removed from FAQ."
        else
          case @info[:error]
          when :question
            "I couldn't find any question with the informed id."
          when :answer
            "I couldn't find any answer with the informed id."
          end
        end
      end
    end

  end
end

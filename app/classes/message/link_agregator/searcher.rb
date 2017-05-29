module Message
  module LinkAgregator

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
        message =  "See what links I found here\n\n"

        @info[:links].each do |link|
          message += "*#{link.id} - #{link.url}\n"
          message += "> #{link.description}\n"

          link.tags.each { |tag| message += "_##{tag.name}_ "}
        end

        message
      end

      def error_message
        case @info[:search]
        when :search
          "Sorry, I couldn't understand what you would like to search."
        else
          "Something wrong happened, and I couldn't perform this search."
        end
      end
    end

  end
end

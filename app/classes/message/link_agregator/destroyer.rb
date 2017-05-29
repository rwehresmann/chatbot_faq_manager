module Message
  module LinkAgregator

    class Destroyer
      def initialize(args)
        @success = args[:success]
        @info = args[:info]
      end

      def show
        if @success
          "Done! Link removed."
        else
          case @info[:error]
          when :link
            "I couldn't find any link with the informed id."
          else
            "I couldn't remove the link."
          end
        end
      end
    end

  end
end

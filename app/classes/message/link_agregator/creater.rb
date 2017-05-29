module Message
  module LinkAgregator

    class Creater
      def initialize(args)
        @success = args[:success]
        @info = args[:info]
      end

      def show
        if @success
          "Done! Link added."
        else
          case @info[:error]
          when :url
            "Action canceled! It's necessary to inform a valid url."
          when :description
            "Action canceled! It's necessary to inform a short description about the link."
          when :tags
            "Action canceled! You need to provide at least one tag to the link."
          end
        end
      end
    end

  end
end

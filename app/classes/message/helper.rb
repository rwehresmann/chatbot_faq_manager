module Message
    class Helper
      def initialize(args)
        @success = args[:success]
        @info = args[:info]
      end

      def show
        if @success
          help_message
        else
          "Something wrong happended tring call 'help'."
        end
      end

      private

      def help_message
        response  = "*This is a list of my _commands_, check it out.* \n\n"

        response  = "*About our FAQ, you can:* \n\n"

        response += "`Add question`\n"
        response += ">Start the process to add a new question to FAQ.\n\n"
        response += "`Delete question _ID_`\n"
        response += ">Remove the question associated to this _ID_.\n\n"
        response += "`Delete answer _ID_`\n"
        response += ">Remove the answer associated to this _ID_.\n\n"
        response += "`List questions`\n"
        response += ">List all our FAQ.\n\n"
        response += "`Search for tag _TAG_`\n"
        response += ">List everithing in our FAQ relationated to this/these tag(s).\n\n"
        response += "`Question with _TERM_`\n"
        response += ">List FAQ based in the _TERM_ that you provided.\n\n"

        response  = "*About our link agregator, you can:* \n\n"

        response += "`Add link`\n"
        response += ">Start the process to add a new link.\n\n"
        response += "`Delete link _ID_`\n"
        response += ">Remove the link associated to this _ID_.\n\n"
        response += "`List links`\n"
        response += ">List all our links.\n\n"
        response += "`links with tag _TAG_`\n"
        response += ">List all our links relationated to this/these tag(s).\n\n"
        response += "`Links with _TERM_`\n"
        response += ">List links based in the _TERM_ that you provided.\n\n"

        response += "This is it. Just for note: always when tags are needed, you should provide them separated by spaces or commas.\n\n"
        response += "If you need my help again, just type `help`.\n\n\n\n"
      end
    end
end

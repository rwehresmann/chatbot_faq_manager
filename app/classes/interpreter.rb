class Interpreter
  ACTION_MAP = {
    "create" => :Creater,
    "search" => :Searcher,
    "destroy" => :Destroyer,
    "help" => :Helper
  }

  MODULE_MAP = {
    "faq" => :"Faq::",
    "link" => :"LinkAgregator::",
    "general" => ""
  }

  def self.call(action, args = {})
    action = action.to_s.split("_")
    module_rep = MODULE_MAP[action[0]]
    action_class = ACTION_MAP[action[1]]

    begin
      response = "#{module_rep}#{action_class}"
        .safe_constantize
        .new(args)
        .call
      "Message::#{module_rep}#{action_class}"
        .safe_constantize
        .new(response)
        .show
    rescue Exception => e
      puts e.message
      puts e.backtrace
      "I couldn't understand this action."
    end
  end
end

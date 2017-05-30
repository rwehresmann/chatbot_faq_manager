class Interpreter
  ACTION_MAP = {
    "create" => :Creater,
    "search" => :Searcher,
    "destroy" => :Destroyer
  }

  MODULE_MAP = {
    "faq" => :Faq,
    "link" => :LinkAgregator
  }

  def self.call(action, args = {})
    action = action.to_s.split("_")

    begin
      response = "#{MODULE_MAP[action[0]]}::#{ACTION_MAP[action[1]]}"
        .safe_constantize
        .new(args)
        .call
      "Message::#{MODULE_MAP[action[0]]}::#{ACTION_MAP[action[1]]}"
        .safe_constantize
        .new(response)
        .show
    rescue
      "I couldn't understand this action."
    end
  end
end

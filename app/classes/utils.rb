module Utils
  def split_tags(tags)
    tags.split(/[\s,]+/)
  end

  def error_hash(error)
    { success: false, info: { error: error } }
  end

  def success_hash(args = {})
    { success: true, info: args }
  end

  # Following the pattern of an action name, the last piece will be the search
  # type in a search action.
  def search_type(search_action_name)
    search_action_name.split("_").last
  end
end

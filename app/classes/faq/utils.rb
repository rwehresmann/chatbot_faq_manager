module Faq
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
  end
end

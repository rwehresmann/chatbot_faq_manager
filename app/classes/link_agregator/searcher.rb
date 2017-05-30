module LinkAgregator
  class Searcher
    include Utils

    def initialize(args = {})
      @search = args[:search]
      @query = args[:query]
    end

    def call
      case @search
      when "term"
        links = Link.search(@query)
      when "tag"
        tags = split_tags(@query)
        links = LinkByTagQuery.new.call(tags)
      when "all"
        links = Link.all
      else
        return error_hash(:search)
      end

      success_hash(links: links)
    end
  end
end

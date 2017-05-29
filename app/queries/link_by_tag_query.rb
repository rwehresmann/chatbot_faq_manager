class LinkByTagQuery
  def initialize(relation = Link.all)
    @relation = relation
  end

  def call(tags = [])
    @relation.includes(:tags).where(tags: { name: tags })
  end
end

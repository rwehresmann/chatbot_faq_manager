class QuestionByTagQuery
  def initialize(relation = Question.all)
    @relation = relation
  end

  def call(tags = [])
    @relation.includes(:tags).where(tags: { name: tags })
  end
end

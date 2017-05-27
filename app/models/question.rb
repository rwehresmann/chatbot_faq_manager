class Question < ActiveRecord::Base
  has_and_belongs_to_many :tags
  has_many :answers, dependent: :destroy

  validates_presence_of :description

  def add_answer(answer)
    self.answers << answer
  end

  def add_tag(tag)
    self.tags << tag
  end

  def should_be_destroyed?
    answers.count == 0
  end
end

class Tag < ActiveRecord::Base
  has_and_belongs_to_many :questions
  has_and_belongs_to_many :links

  validates_presence_of :name

  def should_be_destroyed?
    questions.count == 0 && links.count == 0
  end
end

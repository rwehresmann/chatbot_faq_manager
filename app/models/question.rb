class Question < ActiveRecord::Base
  has_and_belongs_to_many :tags
  has_many :answers

  validates_presence_of :description
end

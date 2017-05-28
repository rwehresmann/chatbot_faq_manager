class Answer < ActiveRecord::Base
  belongs_to :question, optional: false

  validates_presence_of :content
end

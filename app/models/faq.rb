class Faq < ActiveRecord::Base
  has_many :faq_hashtags
  has_many :hashtags, through: :faq_hashtags
  belongs_to :company

  validates_presence_of :question, :answer
end

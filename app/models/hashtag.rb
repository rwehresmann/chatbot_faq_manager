class Hashtag < ActiveRecord::Base
  belongs_to :company
  has_many :faq_hashtags
  has_many :faqs, through: :faq_hashtags

  validates_presence_of :name
end

class Company < ActiveRecord::Base
  has_many :faqs
  has_many :hashtags

  validates_presence_of :name
end

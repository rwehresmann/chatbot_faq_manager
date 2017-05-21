require 'pg_search'

class Faq < ActiveRecord::Base
  include PgSearch

  has_many :faq_hashtags
  has_many :hashtags, through: :faq_hashtags
  belongs_to :company

  validates_presence_of :question, :answer

  pg_search_scope :search, :against => [:question, :answer]
end

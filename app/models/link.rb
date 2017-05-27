class Link < ActiveRecord::Base
  has_and_belongs_to_many :tags

  validates_presence_of :url, :description
end

class FaqHashtag < ActiveRecord::Base
  belongs_to :faq
  belongs_to :hashtag
end

class CreateFaqHashtags < ActiveRecord::Migration[5.1]
  def change
    create_table :faq_hashtags do |t|
      t.references :faq
      t.references :hashtag
    end
  end
end

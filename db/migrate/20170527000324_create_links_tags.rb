class CreateLinksTags < ActiveRecord::Migration[5.1]
  def change
    create_table :links_tags do |t|
      t.references :link, :tag
      t.timestamps
    end
  end
end

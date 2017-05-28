class CreateQuestionsTags < ActiveRecord::Migration[5.1]
  def change
    create_table :questions_tags do |t|
      t.references :question, :tag
      t.timestamps
    end
  end
end

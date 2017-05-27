class CreateAnswers < ActiveRecord::Migration[5.1]
  def change
    create_table :answers do |t|
      t.string :content, null: false
      t.references :question
      t.timestamps
    end
  end
end

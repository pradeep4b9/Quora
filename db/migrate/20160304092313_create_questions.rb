class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.text :title
      t.text :description
      t.integer :votes
      t.references :user

      t.timestamps
    end
    add_index :questions, :user_id
  end
end

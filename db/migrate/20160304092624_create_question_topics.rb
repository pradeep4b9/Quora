class CreateQuestionTopics < ActiveRecord::Migration
  def change
    create_table :question_topics do |t|
      t.references :question
      t.references :topic

      t.timestamps
    end
    add_index :question_topics, :question_id
    add_index :question_topics, :topic_id
    add_index :question_topics, [:question_id, :topic_id], unique: true
  end
end

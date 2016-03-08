class CreateUserTopics < ActiveRecord::Migration
  def change
    create_table :user_topics do |t|
      t.references :user
      t.references :topic

      t.timestamps
    end
    add_index :user_topics, :user_id
    add_index :user_topics, :topic_id
    add_index :user_topics, [:user_id, :topic_id], unique: true
  end
end

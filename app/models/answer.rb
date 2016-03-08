class Answer < ActiveRecord::Base
  attr_accessible :body, :question_id, :user_id, :votes

  belongs_to :user, foreign_key: :user_id
  belongs_to :question, foreign_key: :question_id
    
  has_many :comments, foreign_key: :answer_id

  validates :body, :question_id, presence: true

end

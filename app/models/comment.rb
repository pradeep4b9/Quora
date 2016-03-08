class Comment < ActiveRecord::Base
  attr_accessible :body, :answer_id, :updated_at

  belongs_to :user, foreign_key: :user_id
  belongs_to :answer, foreign_key: :answer_id

  validates :body, :answer_id, presence: true

end

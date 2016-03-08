class Question < ActiveRecord::Base
  attr_accessible :description, :title, :votes, :user_id, :topics

  belongs_to :user, foreign_key: :user_id

  has_many :topics, :through => :question_topics
  has_many :question_topics

  has_many :answers

  validates :title, presence: true
end

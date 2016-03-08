class Topic < ActiveRecord::Base
  attr_accessible :description, :title

  has_many :question_topics
  has_many :questions, :through => :question_topics

  has_many :user_topics
  has_many :users, through: :user_topics

  before_save do |topic|
    topic.title.downcase!
  end

  validates :title, presence: true, uniqueness: true

end

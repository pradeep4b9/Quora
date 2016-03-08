class UserTopic < ActiveRecord::Base
  attr_accessible :topic_id, :user_id

  belongs_to :user
  belongs_to :topic

  validates :user, :topic, presence: true

  validates_uniqueness_of :user_id, :scope => :topic_id 

end

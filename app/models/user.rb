class User < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :email, 
                  :password, :followers, :followed_users, :avatar
  has_secure_password

  before_save :create_remember_token

  validates :first_name, presence: true, length: { maximum: 50 }
  validates :last_name, presence: true, length: { maximum: 50 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:   true,
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
                    
  validates :password, length: { minimum: 6 }

  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed

  has_many :reverse_relationships, foreign_key: "followed_id",
                                   class_name:  "Relationship",
                                   dependent:   :destroy
  has_many :followers, through: :reverse_relationships, source: :follower  

  has_attached_file :avatar,
                    :default_url => "http://www.hovingpartners.ch/wp-content/uploads/2015/11/img-profile-missing.png"

  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
                                    
  has_many :answers, foreign_key: :user_id
  has_many :questions, foreign_key: :user_id
  has_many :comments, foreign_key: :user_id

  has_many :user_topics 
  has_many :topics, through: :user_topics


  def following?(other_user)
    relationships.find_by_followed_id(other_user.id)
  end

  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    relationships.find_by_followed_id(other_user.id).destroy
  end

  private
    
    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
end
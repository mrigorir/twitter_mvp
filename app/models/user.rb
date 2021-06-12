class User < ApplicationRecord
  validates :username, presence: true, uniqueness: true, length: { maximum: 10 }
  validates :fullname, presence: true, length: { maximum: 60 }
  before_save { username.downcase! }
  has_one_attached :avatar

  has_many :created_opinions, foreign_key: :author_id, class_name: 'Opinion', dependent: :destroy

  has_many :followers, foreign_key: :follower_id, class_name: 'Follow'
  has_many :user_followers, through: :followers, source: :follower

  has_many :followings, foreign_key: :following_id, class_name: 'Follow', dependent: :destroy
  has_many :user_followings, through: :followings, source: :following


  def not_following
    User.all.where.not(id: user_followers.select(:id)).where.not(id: id).order(created_at: :desc) 
  end

  def follow_user(user)
    @follow = Follow.create(follower_id: id, following_id: user)
    @user = User.find(user)
    @user.count_following += 1
    self.count_followers += 1
    @user.save
    save
  end

  def unfollow_user(user)
    @follow = Follow.find_by(following_id: user ).destroy
    @user = User.find(user)
    @user.count_following -= 1
    self.count_followers -= 1
    @user.save
    save
  end

  def already_follow?(user)
    true if Follow.find_by(follower_id: id, following_id: user)
  end
end

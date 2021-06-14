class User < ApplicationRecord
  validates :username, presence: true, length: { maximum: 10 }, uniqueness: true
  validates :fullname, presence: true, length: { maximum: 60 }

  before_save { username.downcase! }

  has_one_attached :avatar

  has_many :created_opinions, foreign_key: :author_id, class_name: 'Opinion', dependent: :destroy

  # Will return an array of follows for the given user instance
  has_many :received_follows, foreign_key: :following_id, class_name: 'Follow'

  # Will return an array of users who follow the user instance
  has_many :followers, through: :received_follows, source: :follower

  # returns an array of follows a user gave to someone else
  has_many :given_follows, foreign_key: :follower_id, class_name: 'Follow'

  # returns an array of other users who the user has followed
  has_many :followings, through: :given_follows, source: :followed_user

  def not_following
    User.all.where.not(id: followings.select(:id)).where.not(id: id).order(created_at: :desc)
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
    @follow = Follow.find_by(following_id: user).destroy
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

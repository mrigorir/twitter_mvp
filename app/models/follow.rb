class Follow < ApplicationRecord
  validates :follower_id, presence: true
  validates :following_id, presence: true

  # The user giving the follow
  belongs_to :follower, foreign_key: :follower_id, class_name: 'User'

  # The user being followed
  belongs_to :followed_user, foreign_key: :following_id, class_name: 'User'
end

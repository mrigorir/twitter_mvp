class AddIndexToFollow < ActiveRecord::Migration[6.1]
  def change
    add_index :follows, :follower_id
    add_index :follows, :following_id
  end
end

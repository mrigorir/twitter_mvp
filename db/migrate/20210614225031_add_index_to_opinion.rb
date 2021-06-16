class AddIndexToOpinion < ActiveRecord::Migration[6.1]
  def change
    add_index :opinions, :author_id
  end
end

class RemovePostIdFromRatings < ActiveRecord::Migration
  def change
    remove_column :ratings, :post_id, :integer
  end
end

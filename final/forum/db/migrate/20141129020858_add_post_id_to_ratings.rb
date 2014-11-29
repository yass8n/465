class AddPostIdToRatings < ActiveRecord::Migration
  def change
    add_column :ratings, :post_id, :integer
  end
end

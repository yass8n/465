class AddRatingScoreToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :rating_score, :integer
  end
end

class AddRatingScoreToComments < ActiveRecord::Migration
  def change
    add_column :comments, :rating_score, :integer
  end
end

class CreateCommentaries < ActiveRecord::Migration
  def change
    create_table :commentaries do |t|
      t.integer :post_id
      t.integer :answer_id
      t.integer :user_id
      t.text :comment

      t.timestamps
    end
  end
end

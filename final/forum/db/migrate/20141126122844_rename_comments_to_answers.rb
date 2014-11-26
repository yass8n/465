class RenameCommentsToAnswers < ActiveRecord::Migration
  def change
    rename_table :comments, :answers
  end
end

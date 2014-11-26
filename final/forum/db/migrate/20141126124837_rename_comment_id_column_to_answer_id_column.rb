class RenameCommentIdColumnToAnswerIdColumn < ActiveRecord::Migration
  def change
  	rename_column :ratings, :comment_id, :answer_id
  end
end

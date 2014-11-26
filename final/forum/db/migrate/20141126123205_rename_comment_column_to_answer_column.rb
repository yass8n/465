class RenameCommentColumnToAnswerColumn < ActiveRecord::Migration
  def change 
  	rename_column :answers, :comment, :answer
  end
end

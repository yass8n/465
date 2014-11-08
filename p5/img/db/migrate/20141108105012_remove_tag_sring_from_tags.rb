class RemoveTagSringFromTags < ActiveRecord::Migration
  def change
    remove_column :tags, :tag_string, :string
  end
end

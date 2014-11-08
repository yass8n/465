class AddTagStringFromTags < ActiveRecord::Migration
  def change
    add_column :tags, :tag_string, :string
  end
end

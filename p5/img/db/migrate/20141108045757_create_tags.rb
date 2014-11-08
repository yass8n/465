class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :tag_string
      t.integer :image_id
      t.references :image, index: true

      t.timestamps
    end
  end
end

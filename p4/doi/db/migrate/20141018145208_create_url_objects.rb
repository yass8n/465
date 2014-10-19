class CreateUrlObjects < ActiveRecord::Migration
  def change
    create_table :url_objects do |t|
      t.string :url
      t.references :doi_object, index: true

      t.timestamps
    end
  end
end

class CreateDoiObjects < ActiveRecord::Migration
  def change
    create_table :doi_objects do |t|
      t.string :name
      t.string :description

      t.timestamps
    end
  end
end

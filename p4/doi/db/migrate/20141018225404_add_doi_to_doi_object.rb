class AddDoiToDoiObject < ActiveRecord::Migration
  def change
    add_column :doi_objects, :doi, :string
  end
end

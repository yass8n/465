class RemovePrivateFromImages < ActiveRecord::Migration
  def change
    remove_column :images, :private, :boolean
  end
end

class AddPaypalLinkToUsers < ActiveRecord::Migration
  def change
    add_column :users, :paypal_link, :string
  end
end

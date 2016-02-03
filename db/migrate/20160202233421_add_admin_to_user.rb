class AddAdminToUser < ActiveRecord::Migration
  def change
    add_column :users, :user, :string
    add_column :users, :admin, :boolean
  end
end

class RemoveAdminIdFromCommunity < ActiveRecord::Migration[7.0]
  def change
    remove_column :communities, :admin_id, :integer
  end
end

class RemoveDeveloperIdFromBug < ActiveRecord::Migration[5.0]
  def change
    remove_column :bugs, :developer_id, :integer
  end
end

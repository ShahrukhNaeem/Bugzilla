class AddDeveloperIdToBugs < ActiveRecord::Migration[5.0]
  def change
    add_column :bugs, :developer_id, :integer
  end
end

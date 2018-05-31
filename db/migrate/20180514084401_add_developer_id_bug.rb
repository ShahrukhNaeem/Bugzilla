class AddDeveloperIdBug < ActiveRecord::Migration[5.0]
  def change
  	    add_column :bugs, :developer_id, :integer
  	    add_foreign_key :bugs, :user, column: :developer_id

  end
end

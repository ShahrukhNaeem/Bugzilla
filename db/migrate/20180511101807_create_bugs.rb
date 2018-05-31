class CreateBugs < ActiveRecord::Migration[5.0]
  def change
    create_table :bugs do |t|
      t.string :title
      t.date :deadline
      t.string :screenshot
      t.string :status
      t.string :type
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end

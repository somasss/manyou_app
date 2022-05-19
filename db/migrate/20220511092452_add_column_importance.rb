class AddColumnImportance < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :importance, :integer, null: false, default: 0
  end
end

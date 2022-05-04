class AddDetailsAndNameToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :name, :string
    add_column :tasks, :detail, :string
  end
end

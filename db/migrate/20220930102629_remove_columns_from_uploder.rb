class RemoveColumnsFromUploder < ActiveRecord::Migration[6.1]
  def change
    remove_column :uploders, :file_name, :string
  end
end

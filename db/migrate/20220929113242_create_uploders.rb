class CreateUploders < ActiveRecord::Migration[6.1]
  def change
    create_table :uploders do |t|

      t.timestamps
    end
  end
end

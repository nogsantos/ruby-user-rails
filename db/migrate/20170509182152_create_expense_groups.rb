class CreateExpenseGroups < ActiveRecord::Migration[5.1]
  def change
    create_table :expense_groups do |t|
      t.string :name
      t.boolean :status
      t.text :observation

      t.timestamps
    end
  end
end

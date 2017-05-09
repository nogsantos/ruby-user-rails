class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password
      t.string :username
      t.boolean :status

      t.timestamps
    end

    add_index :username, :email, :uniqueness => true
    
  end
end

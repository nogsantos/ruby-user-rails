class CreateV1Users < ActiveRecord::Migration[5.1]
  def change
    create_table :v1_users do |t|
      t.string :name
      t.string :email
      t.string :password      
      t.string :username
      t.boolean :status

      t.timestamps
    end
  end
end

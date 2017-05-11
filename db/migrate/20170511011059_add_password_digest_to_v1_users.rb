class AddPasswordDigestToV1Users < ActiveRecord::Migration[5.1]
  def change
    add_column :v1_users, :password_digest, :string
  end
end

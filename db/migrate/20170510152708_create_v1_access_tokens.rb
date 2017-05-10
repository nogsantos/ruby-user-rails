class CreateV1AccessTokens < ActiveRecord::Migration[5.1]
  def change
    create_table :v1_access_tokens do |t|
      t.references :user, foreign_key: true
      t.string :access_token
      t.string :token_type
      t.timestamp :expires_at

      t.timestamps
    end
  end
end

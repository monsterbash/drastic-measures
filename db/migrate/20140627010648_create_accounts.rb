class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.integer :user_id
      t.string :provider
      t.string :oauth_token
      t.string :oauth_secret

      t.timestamps
    end
  end
end

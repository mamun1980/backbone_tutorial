class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :email
      t.string :password
      t.string :display_name
      t.boolean :verified_email
      t.string :auth_token
      t.string :username

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end

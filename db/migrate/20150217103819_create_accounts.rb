class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :user_name
      t.string :email
      t.string :password
      t.integer :user_id

      t.timestamps
    end
  end
end

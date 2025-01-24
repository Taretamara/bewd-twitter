class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.timestamps

      t.index :username, unique: true
      t.index :email, unique: true
    end
  end
end

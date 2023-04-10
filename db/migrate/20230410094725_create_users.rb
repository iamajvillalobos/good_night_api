class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name, allow_nil: false
      t.string :auth_token, allow_nil: false

      t.timestamps
    end
    add_index :users, :auth_token
  end
end

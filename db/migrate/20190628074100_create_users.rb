class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :first_last_name
      t.string :username
      t.string :password_digest
      t.datetime :joined
    end
  end
end

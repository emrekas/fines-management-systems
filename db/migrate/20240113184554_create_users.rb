class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :email
      t.string :password
      t.string :name
      t.string :surname
      t.string :national_id
      t.date :date_of_birth
      t.string :phone_number
      t.string :role

      t.timestamps
    end
    add_index :users, :email, unique: true
  end
end

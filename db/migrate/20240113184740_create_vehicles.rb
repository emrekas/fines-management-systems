class CreateVehicles < ActiveRecord::Migration[7.1]
  def change
    create_table :vehicles do |t|
      t.string :plate_number
      t.string :type
      t.string :make
      t.integer :year_of_production
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end

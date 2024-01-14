class CreateFines < ActiveRecord::Migration[7.1]
  def change
    create_table :fines do |t|
      t.string :reason
      t.string :place
      t.datetime :time_of_issue
      t.decimal :amount
      t.string :payment_status
      t.decimal :penalty_amount
      t.references :vehicle, null: false, foreign_key: true

      t.timestamps
    end
  end
end

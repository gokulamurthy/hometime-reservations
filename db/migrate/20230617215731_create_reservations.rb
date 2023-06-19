class CreateReservations < ActiveRecord::Migration[6.1]
  def change
    create_table :reservations do |t|
      t.string :code
      t.date :start_date
      t.date :end_date
      t.integer :nights
      t.integer :guests
      t.string :status
      t.float :security_price
      t.float :payout_price
      t.float :total_price
      t.string :currency

      t.references :guest, null: false, foreign_key: true

      t.timestamps
    end
  end
end

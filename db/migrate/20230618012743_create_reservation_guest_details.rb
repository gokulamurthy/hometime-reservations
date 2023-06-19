class CreateReservationGuestDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :reservation_guest_details do |t|
      t.integer :adults
      t.integer :children
      t.integer :infants
      t.text :description

      t.references :reservation, null: false, foreign_key: true

      t.timestamps
    end
  end
end

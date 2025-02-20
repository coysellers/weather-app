class CreateLocations < ActiveRecord::Migration[8.0]
  def change
    create_table :locations do |t|
      t.string :address
      t.string :ip_address
      t.decimal :latitude
      t.decimal :longitude

      t.timestamps
    end
  end
end

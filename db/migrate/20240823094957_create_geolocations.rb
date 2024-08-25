# frozen_string_literal: true

class CreateGeolocations < ActiveRecord::Migration[7.1]
  def change
    create_table :geolocations do |t|
      t.string :ip_address, null: false
      t.string :url, null: false
      t.string :country, null: false
      t.string :city, null: false
      t.float :latitude, null: false
      t.float :longitude, null: false

      t.timestamps
    end

    add_index :geolocations, :ip_address, unique: true
    add_index :geolocations, :url, unique: true
  end
end

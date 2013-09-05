class CreateProperties < ActiveRecord::Migration
  def change
    create_table :properties do |t|
      t.integer :property_id
      t.integer :amenities

      t.timestamps
    end
  end
end

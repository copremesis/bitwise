class CreateAmenities < ActiveRecord::Migration
  def change
    create_table :amenities do |t|
      t.string :amenity
    end
  end
end

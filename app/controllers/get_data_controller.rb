class GetDataController < ApplicationController
  def index 
    commands = {
      'Amenity' => Rails.cache.fetch('Amenity'), # { Amenity.all.map(&:amenity).inspect },
      'Property' => Rails.cache.fetch('Property'), # { Property.all.to_json},
      'constellation' =>  Property.all.map(&:amenities).inspect 
    }
    render :text =>  commands[params[:data]] || ''
  end

end

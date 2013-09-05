class GetDataController < ApplicationController
  def index 
    commands = {
      'Amenity' => Rails.cache.fetch('Amenity'),
      'Property' => Rails.cache.fetch('Property'),
      'constellation' =>  Property.all.map(&:amenities).inspect 
    }
    render :text =>  commands[params[:data]] || ''
  end

end

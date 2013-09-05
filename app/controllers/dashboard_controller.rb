class DashboardController < ApplicationController
  def index
    @properties = Property.all
  end

  #GET
  def flag_table
    @properties = Property.all
    render :layout => false
  end

  #GET
  def edit_in_place
    #can pass a param here of which thing you want to do that to 
    render :layout => false
  end

  #PUT
  def update
    c = Property.where(:property_id => params['pid']).first  
    c.amenities = params['flags']
    render :text => c.save
  end
#amentities
  def push
    #must sanitize
    Amenity.create(:amenity => params[:amenity]) if params[:amenity] != nil
    render :text => 'success'
  end

  def pop
    Amenity.last.destroy()
    render :text => 'success'
  end
end

        

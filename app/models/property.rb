class Property < ActiveRecord::Base
  include ModelExport

  @@amenities = Rails.cache.fetch('amenities') { Amenity.all.map(&:amenity) }

  #determine the index of the maching amenity then raise 2 to the power of it's index ... i'm using bitwise shift which is faster than 2 ** i  
  #additionally this will need to be refactored to not use [].index but rather have a hash ... this will be done after some tests are made
  #if the passed in amenity does not exist it is assigned the value of the n+1 amenity which does not exist and therefore returns false
  #OR-ing with zero causes undesired results

  def has_amenity?(amenity)
    index = @@amenities.index(amenity) 
    self.amenities | 1 << (index || @@amenities.size) == self.amenities
  end


  #returns an array of the amenities of the given property using the amenitiy dictionary
  #and the bitwise flag assigned to this property

  def human_amenities
    a = []
    @@amenities.each_with_index {|e, i|
      a << e if (self.amenities | 1 << (i) == self.amenities)
    }
    a
  end

  #this method will determine the bit mask of many amenities  
  #then it will use that bit mask to return all Properties with matching amenities
  #if the passed in amenity does not exist it is assigned the value of the n+1 amenity which does not exist and therefore returns false
  #OR-ing with zero causes undesired results

  def self.with_amenities(*args)
    mask = args.reduce(0) {|mask, amenity| 
      index = @@amenities.index(amenity)
      mask |= 1 << (index || @@amenities.size) 
    }
    self.where("amenities | ? == amenities", mask)
  end
end

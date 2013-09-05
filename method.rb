

Amenity.destroy_all
(0..24).map{|i| 
  Amenity.create(:amenity => i) 
}


#useful methods

methods = {
 c_ionian: [416, 352, 176, 168, 168, 0, 0 ], #key of C
 c_natural: [0, 0, 0, 0, 8, 0],
 reset: ->() { Property.all.map {|p| p.update_attributes(:amenities => 0) }},
 frets: ->() { Amenity.all.each_with_index {|a, i| a.update_attributes(:amenity => i)}},
 backup: ->() { Amenity.all.map(&:amenity).to_json },
 constellation: ->() { Property.all.map(&:amenities) },
 down_n_frets: ->(n) { Property.all.map {|p| p.update_attributes(:amenities => p.amenities >> n)} },
 up_n_frets: ->(n) { 
                        Property.all.map {|p| 
                          p.update_attributes(amenities: p.amenities << n)
                        } 
                      },
 animation: ->() { 6.times {
                        methods[up_n_frets].call(1) #can parameterize down/up
                        sleep(10)
                      }},
 load_constellation: ->(constellation) {
                          Property.all.zip(constellation).each {|pair|
                            string, notes = pair  
                            string.update_attributes(:amenities => notes)
                          }
                        },
  up_n_strings: ->(n) {
     c = methods[:constellation].call #self call current constellation
     n.times { c.shift }
     methods[:load_constellation].call(c + (0...n).map { 0 })
  },
  down_n_strings: ->(n) {
     c = methods[:constellation].call #self call current constellation
     n.times { c.pop }
     methods[:load_constellation].call((0...n).map {0} + c)
  },
  #top 4 strings
  octave_up: ->() {
    methods[:up_n_strings].call(2)
    methods[:up_n_frets].call(2)
  },
  octave_down: ->() {
    methods[:down_n_strings].call(2)
    methods[:down_n_frets].call(2)
  },
}

#reuse[:frets][]
#=> "[\"Free Wifi\",\"Washer/Dryer\",\"Pets Allowed\",\"Pet Park\",\"Trash Valet\",\"5 minutes from Downtown\",\"Zen Garden\",\"Hardwood Floors\",\"Swimming Pool\",\"Office\",\"Microwave\",\"Gym\",\"Swimming pool\",\"Air Conditioner\"]" 
#reuse[:backup][]
#reuse[:frets][]
#user defined
#methods[:constellation].call
#C Ionian: [416, 352, 176, 168, 168, 0, 0]
#B Ionian:  => [208, 176, 88, 84, 84, 0, 0]
#methods[:reset].call
#methods[:constellation].call
#oh nice so to move down a fret simply take a constellation and divide all numbers by two ... yet 
#since we're using bits .... shift the bits !!!!
#and the inverse is also true
#so with this ... this will make a B scale become a C scale
#methods[:one_fret_up].call
#amnimation concept
#now to find poll a song's time stamp and have ideas (constellations) to play based on timestamps?
#Property.last.destroy

#methods[:down_n_frets].call(3)
#methods[:constellation].call()

#http://en.wikipedia.org/wiki/Iwato_scale read more .. stuff i didn't know but I use an inversion of it quite a bit
#(spelled 1 b2 b3 4 b5 b6 b7)
#
#methods[:animation].call
#methods[:constellation].call
#some iwato inversion ... one of my favorites:  => [71680, 8192, 41472, 8192, 26624, 0]
#so we need a feature called load constellation ... should be faily simple
#constellation = [71680, 8192, 41472, 8192, 26624, 0]
#
#now all I have to do is build tons of constellations to discuss and add properties to
# we can keep them all defined in one specific key etc yet as of now I've been defining them in concert C and can transpose now that we have the shift left/right idea 

#methods[:reset].call #reset

#what we could also do is have chord finder based on the set of notes provided ... this would make for some interesting programming 

#so now we can move to a chord progression here:
#I call this the deathmetal giant steps: Bm Bb Ebm D Gm F# (and repeat) 
#yet as simple as this appears there's 6 constellations to memorize so here's where it gets interesting...

#sings flats and sharps to play nice with the ruby syntax going to adopt Lilypond's syntax ... and yes this idea will eventually
#tie into my lilypond project ... I feel it is much easier to understand guitar this way then to read a bunch of sheet music ... 
#whats nice is I can eventually publish these as tabbed exercises using lilypond
#convention: assume major unless the m is present, is -> sharp & es -> flat

study = {
  bm:   [17408, 4096, 2048, 4608, 0, 0],
  bes:  [9216,  2048, 1024, 4352, 0, 0],
  eesm: [18432, 2048, 2048, 8448, 0, 0],
  d:    [17408, 1024, 2048, 4224, 0, 0],
  gm:   [33792, 2048, 4096, 4352, 0, 0],
  fis:  [16896, 2048, 2048, 2304, 0, 0],
} #keep in mind order of insertion is preserved in ruby 1.9 which also why this is explicity written in 1.9 hash syntax

#now we can flip back and forth between these two:
0.times {
  study.each {|constellation, notes|
    methods[:load_constellation].call(notes)
    sleep(10)
  }
}

#method[:load_constellation].call(method[:ionian].call())
#methods[:load_constellation].call(methods[:ionian])
#methods[:load_constellation].call(methods[:c_natural].to_a)
#methods[:down_string].call()


#methods[:octave_down].call


#methods[:load_constellation].call(study[:d])
#methods[:constellation].call()
#methods[:constellation].call
#using this method does two things enables me to pool constellations based on my recollection
#without having to thing of the bits on paper ... sort of way of scaffolding my ideads ... execises examples ...
#from here we have a nice group of notes to use when the chord is being played ... essentially the way to 
#thing of when improvising over a song ... while not sounding to pattern-ish (appegios vs scales)

#now lets do recursive octaves :) !!!!! (:
#given a constellation we should determine all octaves for it this would be the same strategy a performer would use to repeat ideas and 
#understand concepts express through-out the fret board

#similar to the knights tour we need to isolate the manuvers to get octaves ... 

#so now we have up_string and down_string !!!!

#now we have octave_up & octave down
  


#JSON.parse("[\"Free Wifi\",\"Washer/Dryer\",\"Pets Allowed\",\"Pet Park\",\"Trash Valet\",\"5 minutes from Downtown\",\"Zen Garden\",\"Hardwood Floors\",\"Swimming Pool\",\"Office\",\"Microwave\",\"Gym\",\"Swimming pool\",\"Air Conditioner\"]")


->() {
  server_status =  %w(awahlqa2.apts.classifiedventures.com awahldev1.apts.classifiedventures.com ahlrubyqa2.apts.classifiedventures.com ahlrubydev1.apts.classifiedventures.com ahlrubyqa02.apts.classifiedventures.com ahlrubydev01.apts.classifiedventures.com http://ahl-dev.apartments.com/ awahldev1.apts.classifiedventures.com http://ahl2rubys-dev.apartments.com ahlrubydev1.apts.classifiedventures.com http://ahl3rubys-dev.apartments.com ahlrubydev01.apts.classifiedventures.com http://ahl2rubys-qa.apartments.com ahlrubyqa1.apts.classifiedventures.com http://ahl3rubys-qa.apartments.com ahlrubyqa01.apts.classifiedventures.com http://ahl-qa.apartments.com/ awahlqa1.apts.classifiedventures.com).reduce({}) {|h, server|
      if server.match(/http/)
        h.update(server => %x[curl -I #{server}])
      else
        http_server = ['http://', server].join
        h.update(http_server => %x[curl -I #{http_server}])
      end
  }

  server_status.each {|k,v|
    puts [k, ' => '].join
    puts v
  }
}


->() {
  Amenity.destroy_all

  JSON.parse("[\"Free Wifi\",\"Washer/Dryer\",\"Pets Allowed\",\"Pet Park\",\"Trash Valet\",\"5 minutes from Downtown\",\"Zen Garden\",\"Hardwood Floors\",\"Swimming Pool\",\"Office\",\"Microwave\",\"Gym\",\"Swimming pool\",\"Air Conditioner\"]")

["Custom Home Amenity", "Custom Community Amenity", "Custom Pet Policy", "Cats", "Small Dogs (under 25 lbs.)", "Pets Negotiable", "Basketball Court", "Business Center", "Clubhouse", "Doorman", "Elevator(s)", "Fitness Center", "Controlled Gate Access", "Whirlpool/Spa/Sauna", "Laundry Facility", "Playground", "Billiard/Pool Tables", "Swimming Pool(s)", "Tennis Court(s)", "Parking", "Small Building", "Vintage Building", "Cable Ready", "Ceiling Fan(s)", "Extra Storage", "Fireplace", "Attached or Detached Garage", "Carport", "High Speed Internet Access", "Oval Soaking Tubs", "Patio or Balcony", "Washer/Dryer Hookup", "Washer/Dryer in Unit", "Air Conditioning", "Dishwasher", "Eat in Kitchen or Dining Room", "Hardwood Floors", "Loft Layout", "Yard", "Active Adult", "Convenient", "Short-term Available", "Garage", "Alarm System", "Built In Bookshelves", "Free-Weights", "Microwave", "Racquetball Court(s)", "Spacious Closet(s)", "Storage Spaces", "Sunroom", "Tiled Entries", "Vaulted Ceilings", "Hi Speed Internet/Wi-Fi", "Declawing Required", "Large Dogs (over 25 lbs.)", "Pet Interview Required", "Spayed/Neutered", "No Pets Allowed", "Military", "Wheelchair Access", "Furnished"].each {|amen|
    Amenity.create(:amenity => amen)
  }
}#[]


#["Pool", "Allow Pets", "Fitness", "Parking", "A/C", "Hardwood Floors", "Walk-in Closet", "Washer/Dryer in Unit", "Washer/Dryer Hookups", "Laundry Room"].each {|amen|
#  Amenity.create(:amenity => amen)
#}

#args = ['Fitness']
#amenities = Rails.cache.fetch('amenities') { Amenity.all.map(&:amenity) }
#mask = args.reduce(0) {|mask, amenity| mask |= (1 << (amenities.index(amenity) || 0))}


%w(66.249.74.189 118.244.213.59 222.128.198.6 42.96.162.225 106.3.38.178 173.244.161.132 178.216.56.150 193.27.243.138 202.99.97.10 50.115.164.181 216.54.231.78 106.3.38.178 173.244.161.132 178.216.56.150 193.27.243.138 202.99.97.10 31.3.245.178 50.115.164.181 67.205.67.135 114.80.202.30 115.187.63.105 183.80.108.35 77.73.8.125 114.80.224.90 219.235.126.174 37.153.209.2 67.18.178.210)



#useful methods

methods = {
 :reset => ->() { Property.all.map {|p| p.update_attributes(:amenities => 0) }},
 :frets => ->() { Amenity.all.each_with_index {|a, i| a.update_attributes(:amenity => i)}},
 :backup => ->() { Amenity.all.map(&:amenity).to_json },
 :constellation => ->() { Property.all.map(&:amenities) },
 :down_n_frets => ->(n) { Property.all.map {|p| p.update_attributes(:amenities => p.amenities >> n)} },
 :up_n_frets => ->(n) { 
                        Property.all.map {|p| 
                          p.update_attributes(:amenities => p.amenities << n)
                        } 
                      },
 :animation => ->() { 6.times {
                        methods[:up_n_frets].call(1) #can parameterize down/up
                        sleep(10)
                      }},
 :load_constellation => ->(constellation) {
                          Property.all.zip(constellation).each {|pair|
                            string, notes = pair  
                            string.update_attributes(:amenities => notes)
                          }
                        }
                
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
#so we need a feature called load constilation ... should be faily simple
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
  bm: [17408, 4096, 2048, 4608, 0, 0],
  bes: [9216, 2048, 1024, 4352, 0, 0],
  eesm: [18432, 2048, 2048, 8448, 0, 0],
  d: [17408, 1024, 2048, 4224, 0, 0],
  gm: [33792, 2048, 4096, 4352, 0, 0],
  fis: [16896, 2048, 2048, 2304, 0, 0],
}

#now we can flip back and forth between these two:
10.times {
  study.each {|constellation, notes|
    methods[:load_constellation].call(notes)
    sleep(10)
  }
}

#methods[:load_constellation].call(study[:d])
#methods[:constellation].call()

#methods[:constellation].call
#using this method does two things enables me to pool constellations based on my recollection
#without having to thing of the bits on paper ... sort of way of scaffolding my ideads ... execises examples ...
#from here we have a nice group of notes to use when the chord is being played ... essentially the way to 
#thing of when improvising over a song ... while not sounding to pattern-ish (appegios vs scales)


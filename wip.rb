


=begin
s = Amenity.count
100.times {
  r = {property_id: rand(1<<24), amenities: rand(1<<s)}
  Property.create(r)
  sleep(5)
}
=end

#Property.count
=begin
34.times {
  Property.last.destroy
  sleep 10
}
  
=end
#hacking the signed request sent back from facebook to our mymedia app
#this is essentially the way the configuration for the facebook at gets it's
#configuration


payload = '5_11o2eAh_rkY5lKr23KRE36Um_D-QeMXGY7bKl-A8o.eyJhbGdvcml0aG0iOiJITUFDLVNIQTI1NiIsImlzc3VlZF9hdCI6MTM0MzE0Nzc3NSwicGFnZSI6eyJpZCI6IjYzNTg1NzY0Njk5IiwibGlrZWQiOnRydWUsImFkbWluIjpmYWxzZX0sInVzZXIiOnsiY291bnRyeSI6InVzIiwibG9jYWxlIjoiZW5fVVMiLCJhZ2UiOnsibWluIjoyMX19fQ'.split(/\./)[1]
payload += '=' * (4 - payload.length.modulo(4))
#or Base64.decode64(s)
ap JSON.parse(payload.unpack('m')[0])
ap JSON.parse(Base64.decode64(payload))





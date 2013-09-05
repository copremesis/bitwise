module DashboardHelper
  def flags_to_controls(flags) 
    constraints = (0...Amenity.count).map {|x| 2**x} #1, 2, 4, 8 ... 2^n

    controls = constraints.map {|constraint|
      #"    <td class=bit> <input type=checkbox #{((flags & constraint) == constraint)? "checked" : ""} /></td>"
      "    <td class=bit> <input type=checkbox #{((constraint | flags) == flags)? "checked" : ""} /></td>"
    }
    return raw(controls.join("\n"))
  end 
end

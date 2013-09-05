
module Override
module Foo
  extend self
  def foo(msg)
    puts msg
  end
end

class Bar
  include Foo
  def foo(msg) 
    super(msg)
  end
end

Foo.foo('class method')
Bar.new.foo('instance method overried by mixin')

class Vice
  class << self
    def foo(msg)
      puts msg
    end
  end
end

Vice.foo('original class method')

class Versa < Vice
  def self.foo(msg)
    super(msg)
  end
end

Versa.foo('override with inheritance')

#so to overried a class method defined in a class is to 
#use inheritance

class Ad
  def self.some_method
    puts 'long CPU breaking SQL query' 
  end
end

class Ad_ < Ad
  def self.some_method
    puts 'bypass method'
    super()
    puts 'end bypass'
  end
end
Ad_.some_method

end

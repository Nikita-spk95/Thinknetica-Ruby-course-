require_relative 'accessors'
require_relative 'validation'

class X
  extend Accessors
  extend Validation

  attr_accessor_with_history :a, :b, :c

  strong_attr_accessor :d, :d.class
  strong_attr_accessor :e, :e.class
  strong_attr_accessor :f, :f.class

end

class Station
  extend Validation

  attr_accessor :name, :number, :station
end

x = X.new
s = Station.new

s.name = "asd"
Station.validate(s.name, :presence)
puts Station.validate!
puts Station.valid?

s.number = "A"
puts Station.validate(s.number, :format, /A/)
puts Station.validate!
puts Station.valid?

s.number = "A-Z"
puts Station.validate(s.number, :format, /A-Z{0,3}/)
puts Station.validate!
puts Station.valid?

Station.validate(s, :type, Station)
puts Station.validate!
puts Station.valid?

require_relative 'instance_counter'
require_relative 'validation'

class Route
  include InstanceCounter
  include Validation
  attr_reader :stations

  def initialize(first_station, last_station)
    @stations = [first_station, last_station]
    validate!
    register_instance
  end

  def add_station(station)
    stations.insert(-2, station)
  end

  def remove_station(station)
    stations.delete(station)
  end

  protected

  def validate!
    raise "Необходимо создать начальную и конечную станции" if @stations.size < 2
  end
end

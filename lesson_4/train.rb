class Train

  attr_accessor :speed, :carriages, :current_station
  attr_reader :number, :type, :route
  def initialize(number)
    @number = number
    @type = type
    @carriages = []
    @speed = 0
  end

  def speed_up(speed)
    self.speed += speed
  end 

  def stop
    self.speed = 0
  end

  def type
    raise NotImplementedError
  end

  def carriages_count
    carriages.size
  end

  def take_carriage(carriage)
    carriages << carriage if carriage.type == type && speed.zero?
  end

  def drop_carriage
    carriages.delete_at(-1) if speed.zero?
  end

  def take_route(route)
    @route = route
    self.current_station = route.stations.first
    current_station.train_arrival(self)
  end
  
  def move_forward
    return unless next_station
    current_station.train_departure(self)
    self.current_station = next_station
    current_station.train_arrival(self)
  end

  def move_backward
    return unless previous_station
    current_station.train_departure(self)
    self.current_station = previous_station
    current_station.train_arrival(self)
  end

  def next_station
    return unless route
    current_index = route.stations.index(current_station)
    route.stations[current_index + 1] if current_index < route.stations.size - 1
  end

  def previous_station
    return unless route
    current_index = route.stations.index(current_station)
    route.stations[current_index - 1] if current_index.positive?
  end
end

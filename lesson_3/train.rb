class Train

  attr_accessor :speed
  attr_reader :number, :type, :carriages, :current_station
  def initialize(number, type, carriages, speed = 0)
    @number = number
    @type = type
    @carriages = carriages
    @speed = speed
  end

 def speed_up(speed)
    @speed += speed
  end 

  def stop
    @speed = 0
  end

  def take_carriage
    @carriages += 1 if @speed == 0 
  end

  def drop_carriage
    @carriages += 1 if @speed == 0 && @carriages > 0
  end

  def take_route(route)
    @route = route
    @current_station = route.stations.first
    @current_station.add_train(self)
  end
  
  def move_forward
    return unless next_station
    @current_station.send_train(self)
    @current_station = next_station
    @current_station.add_train(self)
  end

  def move_backward
    return unless previous_station
    @current_station.send_train(self)
    @current_station = previous_station
    @current_station.add_train(self)
  end

  def next_station
    return unless @route
    current_index = @route.stations.index(@current_station)
    @route.stations[current_index + 1] if current_index < @route.stations.size - 1
  end

  def previous_station
    return unless @route
    current_index = @route.stations.index(@current_station)
    @route.stations[current_index - 1] if current_index.positive?
  end
end
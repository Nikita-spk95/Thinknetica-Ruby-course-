class Route

   attr_reader :stations_list

  def initialize(first_station, last_station)
    @stations_list = [first_station, last_station]
  end

  def add_station(station)
    @stations_list.insert(-2, station)
  end

  def remove_station(station)
    if [@stations.first, @stations.last].include?(station)
    #условие выполняется - станцию удалить нельзя
    else
      @stations.delete(station)
    end
  end
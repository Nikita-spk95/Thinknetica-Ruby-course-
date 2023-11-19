class Station

  attr_reader :name, :trains

  def initiatize(name)
    @name = name
    @trains = []
  end
    
 def trains_by_type(type)
    trains_array = @trains.select {|train| train.type == type}
  end

  def train_arrival(train)
    @trains << train
  end

  def train_departure
    @trains.delete(train)
  end
end
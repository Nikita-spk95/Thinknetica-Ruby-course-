require_relative 'instance_counter'

class Station
  include InstanceCounter
  attr_reader :name, :trains

  @@all_staions = []

  def self.all
    @@all_staions
  end

  def initialize(name)
    @name = name
    @trains = []
    @@all_staions << self
    register_instance
  end

  def trains_by_type(type)
    trains.select {|train| train.type == type}
  end

  def train_arrival(train)
    trains << train
  end

  def train_departure(train)
    trains.delete(train)
  end
end

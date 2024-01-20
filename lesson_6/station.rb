require_relative 'instance_counter'
require_relative 'validation'

class Station
  include InstanceCounter
  include Validation
  attr_reader :name, :trains

  @@all_staions = []

  def self.all
    @@all_staions
  end

  def initialize(name)
    @name = name
    @trains = []
    validate!
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

  protected

  def validate!
    errors = []
    errors << "Название станции не может быть nil" if @name.nil?
    errors << "Введите название станции (название не может быть пустым)" if @name.empty?
    raise ArgumentError, errors.join(', ') unless errors.empty?
  end
end

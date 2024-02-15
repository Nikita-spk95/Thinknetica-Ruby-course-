# frozen_string_literal: true

class CargoTrain < Train
  def initialize(number)
    super(number, :cargo)
  end

  def take_carriage(carriage)
    return unless type == carriage.type

    super(carriage)
  end
end

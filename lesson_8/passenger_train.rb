# frozen_string_literal: true

class PassengerTrain < Train
  def initialize(number)
    super(number, :passenger)
  end

  def take_carriage(carriage)
    return unless type == carriage.type

    super(carriage)
  end
end

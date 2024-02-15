# frozen_string_literal: true

class PassengerСarriage < Carriage
  attr_reader :used_seats, :seats

  def initialize(seats)
    @seats = seats
    @used_seats = 0
    validate!
    super(:passenger)
  end

  def fill_carriage
    @used_seats + 1 > @seats ? 'Недостаточно мест' : @used_seats += 1
  end

  def free_seats
    @seats - @used_seats
  end

  private

  def validate!
    errors = []
    errors << 'Количество мест не может быть меньше нуля' if @seats.negative?
    errors << 'Превышен лимит по количеству занятых мест' if @used_seats > @seats
    raise ArgumentErrors, errors.join(', ') unless errors.empty?
  end
end

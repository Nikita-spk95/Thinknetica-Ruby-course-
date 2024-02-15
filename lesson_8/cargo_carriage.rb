# frozen_string_literal: true

class CargoСarriage < Carriage
  attr_reader :volume

  def initialize(volume)
    @volume = volume
    @filled = 0
    validate!
    super(:cargo)
  end

  def fill_volume(fill)
    (free_volume - fill).negative? ? 'Недостаточно объема' : @filled += fill
  end

  def used_volume
    @filled
  end

  def free_volume
    @volume - @filled
  end

  private

  def validate!
    errors = []
    errors << 'Объем не может быть меньше нуля' if @volume.negative?
    errors << 'Превышен лимит по занятому объему' if @filled > @volume
    raise ArgumentErrors, errors.join(', ') unless errors.empty?
  end
end

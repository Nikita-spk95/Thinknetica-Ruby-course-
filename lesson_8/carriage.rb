# frozen_string_literal: true

require_relative 'company_manufacture'
require_relative 'validation'

class Carriage
  include CompanyManufacture
  include Validation

  attr_reader :type

  def initialize(type)
    @type = type
    validate!
  end

  private

  def validate!
    errors = []
    errors << "Вагон не может быть nil'" if @type.nil?
    errors << 'Введите коректный тип вагона' unless (@type == :passenger) || (@type == :cargo)
    raise ArgumentError, errors.join(', ') unless errors.empty?
  end
end

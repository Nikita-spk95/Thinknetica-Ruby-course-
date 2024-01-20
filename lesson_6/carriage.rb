require_relative 'company_manufacture'
require_relative 'validation'

class Carriage
  include CompanyManufacture
  include Validation

  def type
    raise NotImplementedError
    validate!
  end

    protected

  def validate!
    errors = []
    errors << "Вагон не может быть nil'" if @type.nil?
    errors << "Введите коректный тип вагона" unless @type == :passenger or @type == :cargo
    raise ArgumentError, errors.join(', ') unless errors.empty?
  end
end

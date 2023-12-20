require_relative 'company_manufacture'

class Carriage
  include CompanyManufacture
  def type
    raise NotImplementedError
  end
end

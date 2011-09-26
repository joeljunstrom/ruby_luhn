# encoding: UTF-8
class String
  def valid_luhn?
    Luhn.valid?(self)
  end

  def civic_number?
    Luhn::CivicNumber.new(self).valid?
  end
end
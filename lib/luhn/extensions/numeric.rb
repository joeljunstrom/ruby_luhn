# encoding: UTF-8
class Numeric

  def valid_luhn?
    self.to_s.valid_luhn?
  end

  def civic_number?
    self.to_s.civic_number?
  end
end
# encoding: UTF-8
require 'luhn/extensions'

module Luhn
  autoload :CivicNumber, 'luhn/civic_number'

  class << self
    def valid?(value)
      self.checksum(value, :odd) % 10 == 0
    end

    def control_digit(value)
      sum = self.checksum(value, :even)
      (sum % 10 != 0) ? 10 - (sum % 10) : 0
    end

    def generate(size, options = {})
      generated = options[:prefix] || ''
      (size - generated.size - 1).times { |i| generated += rand(10).to_s }
      generated + self.control_digit(generated).to_s
    end

  protected

    def checksum(value, operation)
      i = 0
      value.reverse.split(//).inject(0) do |sum, c|
        n = c.to_i
        calc = if operation == :even
          (i % 2 == 0) ? n * 2 : n
        else
          (i % 2 != 0) ? n * 2 : n
        end
        i += 1
        sum += calc <= 9 ? calc : (calc % 10) + 1
      end
    end
  end

end
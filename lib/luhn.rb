# encoding: UTF-8
require "luhn/extensions"

module Luhn
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
      compare_method = (operation == :even) ? :== : :>
      value.reverse.split('').inject(0) do |sum, c|
        n = c.to_i
        weight = (i % 2).send(compare_method, 0) ? n * 2 : n
        i += 1
        sum += weight < 10 ? weight : weight - 9
      end
    end
  end
end

require "luhn/civic_number"

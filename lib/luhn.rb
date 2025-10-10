# frozen_string_literal: true

module Luhn
  def self.valid? value
    LuhnValue.new(value).valid?
  end

  def self.control_digit value
    LuhnValue.new(value).control_digit
  end

  def self.generate size, options = {}
    LuhnValue.generate size, options
  end

  class LuhnValue
    attr_reader :number

    def initialize number
      self.number = number
    end

    def self.generate size, options = {}
      generated = options[:prefix] || ''
      (size - generated.size - 1).times { |i| generated += rand(10).to_s }

      generated + self.new(generated).control_digit.to_s
    end

    def valid?
      number != "" && checksum(:odd) % 10 == 0
    end

    def control_digit
      sum = checksum(:even)
      (sum % 10 != 0) ? 10 - (sum % 10) : 0
    end

    private

    def number= number
      @number = number.to_s.gsub(/\D/, "")
    end

    def checksum(operation)
      i = 0
      compare_method = (operation == :even) ? :== : :>
      self.number.reverse.split("").inject(0) do |sum, c|
        n = c.to_i
        weight = (i % 2).send(compare_method, 0) ? n * 2 : n
        i += 1
        sum += weight < 10 ? weight : weight - 9
      end
    end
  end
end

require "luhn/civic_number"

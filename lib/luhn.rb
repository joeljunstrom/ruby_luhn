# encoding: UTF-8
require 'enumerator'
require 'luhn/extensions'

module Luhn
  autoload :CivicNumber, 'luhn/civic_number'

  class << self
    def valid?(value)
      self.checksum(value, 'verify') % 10 == 0
    end

    def control_digit(value)
      sum = self.checksum(value, 'calculate')
      (sum % 10 != 0) ? 10 - (sum % 10) : 0
    end

    def generate(size, options = {})
      generated = options[:prefix] || ''
      (size - generated.size - 1).times { |i| generated += rand(10).to_s }
      generated + self.control_digit(generated).to_s
    end

  protected

    # TODO remove ruby 1.8.6 compliance and make it speedier,
    # remove silly enums and just use mod % to check for odd / even
    def checksum(value, operation)
      method = case operation
        when 'verify' then :odd?
        when 'calculate' then :even?
        else
          raise ArgumentError.new("operation must equal verify or calculate")
        end
      value.reverse.split(//).enum_for(:each_with_index).map do |n, i|
        n.to_i * (i.send(method) ? 2 : 1)
      end.to_s.split(//).inject(0) { |sum, n| sum += n.to_i }
    end
  end

end
require 'enumerator'
module Luhn
  class CivicNumber

    attr_reader :civic_number

    def initialize(civic_number)
      @civic_number = civic_number.to_s.gsub(/\D/, '')
    end

    def valid?
      civic_number.length == 10 && checksum(civic_number) % 10 == 0
    end

    def control_digit
      10 - checksum(civic_number[0...9]) % 10
    end

    def sex
      valid? ? (civic_number[8...9].to_i.even? ? 'female' : 'male') : 'unknown'
    end

    def female?
      sex == 'female'
    end

    def male?
      sex == 'male'
    end

  private

    def checksum(value)
       value.split(//).enum_for(:each_with_index).map do |n, i|
        n.to_i * (i.even? ? 2 : 1)
      end.to_s.split(//).inject(0) { |sum, n| sum += n.to_i }
    end

  end
end

class String
  def as_civic_number
    Luhn::CivicNumber.new(self)
  end
end

class Numeric
  def as_civic_number
    Luhn::CivicNumber.new(self.to_s)
  end
end
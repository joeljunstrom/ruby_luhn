# encoding: UTF-8
require 'ostruct'
module Luhn
  class CivicNumber
    attr_reader :value

    def initialize string
      self.value = string
    end

    def valid?
      @valid ||= value.length == 10 && valid_date? && Luhn.valid?(value)
    end

    def valid_date?
      (1..12).include?(birth_date.month) && (1..31).include?(birth_date.day)
    end

    def control_digit
      @control_digit ||= Luhn.control_digit(value[0...9])
    end

    def sex
      valid? ? (value[8...9].to_i.even? ? 'female' : 'male') : 'unknown'
    end

    def female?
      sex == 'female'
    end

    def male?
      sex == 'male'
    end

    def birth_date
      OpenStruct.new({
        :year  => value[0...2].to_i,
        :month => value[2...4].to_i,
        :day   => value[4...6].to_i
      })
    end

    def formatted
      return value if value.length < 10

      value.insert(value.length - 4, "-")
    end

    def to_s
      value
    end

    # For backwards compability
    def civic_number
      value
    end

    def self.generate
      date = Time.local(Time.now.year - rand(100) - 1, rand(12) + 1, rand(31) + 1)
      Luhn.generate(10, :prefix => date.strftime("%y%m%d"))
    end

    private

    def value= string
      val = string.to_s.gsub(/\D/, '')
      @value = val.length == 12 ? val[2...12] : val
    end
  end
end

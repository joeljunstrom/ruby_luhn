# frozen_string_literal: true

module Luhn
  class CivicNumber
    attr_reader :value

    BirthDate = Data.define(:year, :month, :day)

    def initialize string
      self.value = string
    end

    def valid?
      @valid ||= value.length == 10 && valid_date? && Luhn.valid?(value)
    end

    def valid_date?
      (1..12).cover?(birth_date.month) && (1..31).cover?(birth_date.day)
    end

    def control_digit
      @control_digit ||= Luhn.control_digit(value[0...9])
    end

    def sex
      return "unknown" unless valid?
      (value[8...9].to_i.even? ? "female" : "male")
    end

    def female?
      sex == "female"
    end

    def male?
      sex == "male"
    end

    def birth_date
      BirthDate.new(
        value[0...2].to_i,
        value[2...4].to_i,
        value[4...6].to_i
      )
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
      date = Time.local(Time.now.year - rand(1..99), rand(1..12), rand(1..31))
      Luhn.generate(10, prefix: date.strftime("%y%m%d"))
    end

    private

    def value= string
      val = string.to_s.gsub(/\D/, "")
      @value = ((val.length == 12) ? val[2...12] : val)
    end
  end
end

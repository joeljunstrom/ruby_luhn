# encoding: UTF-8
require 'ostruct'
module Luhn
  class CivicNumber
    attr_reader :civic_number

    def initialize(string)
      @civic_number = cleanup_string(string.to_s)
    end

    def valid?
      @valid ||= civic_number.length == 10 && valid_date? && Luhn.valid?(civic_number)
    end

    def valid_date?
      (1..12).include?(birth_date.month) && (1..31).include?(birth_date.day)
    end

    def control_digit
      @control_digit ||= Luhn.control_digit(civic_number[0...9])
    end

    def sex
      @sex ||= valid? ? (civic_number[8...9].to_i.even? ? 'female' : 'male') : 'unknown'
    end

    def female?
      sex == 'female'
    end

    def male?
      sex == 'male'
    end

    def birth_date
      @date ||= OpenStruct.new({
        :year  => civic_number[0...2].to_i,
        :month => civic_number[2...4].to_i,
        :day   => civic_number[4...6].to_i
      })
    end

    def to_s
      civic_number
    end

    class << self
      def generate
        date = Time.local(Time.now.year - rand(100) - 1, rand(12) + 1, rand(31) + 1)
        Luhn.generate(10, :prefix => date.strftime("%y%m%d"))
      end
    end

  private

    def cleanup_string(string)
      string.gsub!(/\D/, '')
      string.length == 12 ? string[2...12] : string
    end

  end
end
# Copyright (c) 2010 Joel Junström, Winston Design
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

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
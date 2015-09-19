require 'helper'

describe Luhn::CivicNumber do
  it 'identifies if the civic number is valid' do
    Luhn::CivicNumber.new('3910304298').valid?.must_equal true
  end

  it 'identifies if the civic number is invalid' do
    Luhn::CivicNumber.new('3910304290').valid?.must_equal false
  end

  it 'requires a length of 10 to be valid' do
    luhn_string = Luhn.generate(8, :prefix => '391030')
    Luhn::CivicNumber.new(luhn_string).valid?.must_equal false
  end

  it 'requires the civic number to be a valid date' do
    luhn_string = Luhn.generate(10, :prefix => '3999')
    Luhn::CivicNumber.new(luhn_string).valid?.must_equal false
  end

  it 'calculates the control digit for a valid civic number' do
    Luhn::CivicNumber.new('3910304298').control_digit.must_equal 8
  end

  it 'calculates the correct control digit for an invalid civic number' do
    Luhn::CivicNumber.new('3910304290').control_digit.must_equal 8
  end

  it 'identifies if the civic number belongs to a male' do
    Luhn::CivicNumber.new('3910304298').sex.must_equal 'male'
  end

  it 'identifies if the civic number belongs to a female' do
    Luhn::CivicNumber.new('3910303183').sex.must_equal 'female'
  end

  it 'cleans up civic number with the full year supplied' do
    Luhn::CivicNumber.new('19391030-3183').civic_number.must_equal '3910303183'
  end

  it 'knows the date of birth' do
    civic_number = Luhn::CivicNumber.new('3001018194')
    civic_number.birth_date.year.must_equal 30
    civic_number.birth_date.month.must_equal 1
    civic_number.birth_date.day.must_equal 1
  end

  it "formats the civic number" do
    civic_number = Luhn::CivicNumber.new('3001018194')

    civic_number.formatted.must_equal "300101-8194"
  end

  it 'generates a valid random civic number' do
    civic_number = Luhn::CivicNumber.generate
    Luhn::CivicNumber.new(civic_number).valid?.must_equal true
  end
end

# frozen_string_literal: true

require "helper"

describe Luhn do
  it "identifies if the number is valid" do
    Luhn.valid?("1111111116").must_equal true
  end

  it "identifies if the number is invalid" do
    Luhn.valid?("1111111111").must_equal false
  end

  it "requires numbers" do
    Luhn.valid?("frefre").must_equal false
  end

  it "generates a number string that satisfies luhn" do
    luhn_string = Luhn.generate(rand(1..32))
    Luhn.valid?(luhn_string).must_equal true
  end

  it "generate a number string with the size of the argument" do
    luhn_string = Luhn.generate(5)
    luhn_string.size.must_equal 5
  end

  it "generate a a valid luhn with a given prefix" do
    luhn_string = Luhn.generate(10, prefix: "00001")
    luhn_string.must_match(/^00001/)
    Luhn.valid?(luhn_string).must_equal true
  end

  it "calculates the control digit" do
    Luhn.control_digit("111111111").must_equal 6
  end
end

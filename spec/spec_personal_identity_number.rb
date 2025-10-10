# frozen_string_literal: true

require "helper"

describe Luhn::PersonalIdentityNumber do
  it "identifies if the personal identity number is valid" do
    Luhn::PersonalIdentityNumber.new("3910304298").valid?.must_equal true
  end

  it "identifies if the personal identity number is invalid" do
    Luhn::PersonalIdentityNumber.new("3910304290").valid?.must_equal false
  end

  it "requires a length of 10 to be valid" do
    luhn_string = Luhn.generate(8, prefix: "391030")
    Luhn::PersonalIdentityNumber.new(luhn_string).valid?.must_equal false
  end

  it "requires the personal identity number to be a valid date" do
    luhn_string = Luhn.generate(10, prefix: "3999")
    Luhn::PersonalIdentityNumber.new(luhn_string).valid?.must_equal false
  end

  it "calculates the control digit for a valid personal identity number" do
    Luhn::PersonalIdentityNumber.new("3910304298").control_digit.must_equal 8
  end

  it "calculates the correct control digit for an invalid personal identity number" do
    Luhn::PersonalIdentityNumber.new("3910304290").control_digit.must_equal 8
  end

  it "identifies if the personal identity number belongs to a male" do
    Luhn::PersonalIdentityNumber.new("3910304298").sex.must_equal "male"
  end

  it "identifies if the personal identity number belongs to a female" do
    Luhn::PersonalIdentityNumber.new("3910303183").sex.must_equal "female"
  end

  it "cleans up personal identity number with the full year supplied" do
    Luhn::PersonalIdentityNumber.new("19391030-3183").to_s.must_equal "3910303183"
  end

  it "knows the date of birth" do
    personal_identity_number = Luhn::PersonalIdentityNumber.new("3001018194")
    personal_identity_number.birth_date.year.must_equal 30
    personal_identity_number.birth_date.month.must_equal 1
    personal_identity_number.birth_date.day.must_equal 1
  end

  describe "#formatted" do
    it "formats the personal identity number" do
      personal_identity_number = Luhn::PersonalIdentityNumber.new("3001018194")

      personal_identity_number.formatted.must_equal "300101-8194"
    end

    it "returns the origial if the personal identity number is to short" do
      personal_identity_number = Luhn::PersonalIdentityNumber.new("300101819")

      personal_identity_number.formatted.must_equal "300101819"
    end
  end

  it "generates a valid random personal identity number" do
    personal_identity_number = Luhn::PersonalIdentityNumber.generate
    Luhn::PersonalIdentityNumber.new(personal_identity_number).valid?.must_equal true
  end
end

require 'helper'

describe Luhn::LuhnModN do
  let(:valid_characters){ ('A'..'Z').to_a }

  before do
    @luhn_mod_n = Luhn::LuhnModN.new(valid_characters.join)
  end

  it 'calculates the check_character' do
    @luhn_mod_n.check_character('ABC').must_equal 'V'
  end

  it "identifies if the string is valid" do
    @luhn_mod_n.valid?('ABCV').must_equal true
  end

  it "identifies if the string is valid (ingoring the whitespace)" do
    @luhn_mod_n.valid?("ABCV\n").must_equal true
    @luhn_mod_n.valid?('ABCV ').must_equal true
    @luhn_mod_n.valid?(' ABCV').must_equal true
  end

  it "identifies if the string is invalid" do
    @luhn_mod_n.valid?('ABCX').must_equal false
  end

  it 'generates a string that satisfies luhn mod n' do
    random_string = valid_characters.sample(6).join
    generated_string = @luhn_mod_n.generate(random_string)
    @luhn_mod_n.valid?(generated_string).must_equal true
  end

  it 'raises an exception for a unsupported check character' do
    proc { @luhn_mod_n.valid?('ABC9') }.must_raise(RuntimeError)
  end

  it 'raises an exception for a unsupported character' do
    proc { @luhn_mod_n.valid?('9ABC') }.must_raise(RuntimeError)
  end
end
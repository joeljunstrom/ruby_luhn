require 'helper'

describe String do
  it 'knows if it is a valid luhn' do
    '3910304298'.valid_luhn?.must_equal true
  end

  it 'knows if it is an civic number' do
    '3910304298'.civic_number?.must_equal true
  end
end

describe Numeric do
  it 'knows if it is a valid luhn' do
    3910304298.valid_luhn?.must_equal true
  end

  it 'knows if it is an civic number' do
    3910304298.civic_number?.must_equal true
  end
end
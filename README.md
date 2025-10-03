# Ruby class for handling basic Luhn number generation and verification

Includes a class to handle Swedish civic numbers (Personnummer).

The interface supports checking validity (length, valid date and satisfies luhn),
returning the sex, the control digit, and generating random civic numbers.

## Install

```shell
$ gem install luhn
```

## Usage:

### Basic Luhn

```ruby
Luhn.valid?('0465827879483596')       # true
Luhn.control_digit('046582787948359') # 6
Luhn.generate(n)                      # returns a random number of n length that satisfies luhn

'0465827879483596'.valid_luhn? # true
0465827879483596.valid_luhn?   # true
```

### Swedish civic numbers

```ruby
civic_number = Luhn::CivicNumber.new('19391030-3183')
civic_number.valid?        # true
civic_number.sex           # 'male'
civic_number.male?         # true
civic_number.control_digit # 3

'391030-3183'.civic_number? # true
3910303183.civic_number?    # true
```

## About the Luhn algorithm (from http://en.wikipedia.org/wiki/Luhn_formula)

The Luhn algorithm or Luhn formula, also known as the "modulus 10" or "mod 10"
algorithm, is a simple checksum formula used to validate a variety of
identification numbers, such as credit card numbers, IMEI numbers,
National Provider Identifier numbers in US and Canadian Social Insurance Numbers,
and even South African ID numbers.

It was created by IBM scientist Hans Peter Luhn and described in U.S. Patent
No. 2,950,048, filed on January 6, 1954, and granted on August 23, 1960.

## Copyright

Copyright (c) 2010 Joel Junström. See [LICENSE](LICENSE) for details.

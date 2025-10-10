# Ruby class for handling basic Luhn number generation and verification

Includes a class to handle Swedish personal identity numbers (Personnummer).

The interface supports checking validity (length, valid date and satisfies luhn),
returning the sex, the control digit, and generating random identity numbers.

## Install

```shell
$ gem install luhn
```

## Usage:

### Basic Luhn

```ruby
Luhn.valid?("0465827879483596")       # true
Luhn.control_digit("046582787948359") # 6
Luhn.generate(n)                      # returns a random number of n length that satisfies luhn
```

### Swedish personal identity numbers

```ruby
number = Luhn::PersonalIdentityNumber.new("19391030-3183")
number.valid?        # true
number.sex           # "male"
number.male?         # true
number.control_digit # 3
```

## About the Luhn algorithm

The following is an excerpt from [the Wikipedia article on the Luhn algorithm.](https://en.wikipedia.org/wiki/Luhn_algorithm)

The Luhn algorithm or Luhn formula, also known as the "modulus 10" or "mod 10"
algorithm, is a simple checksum formula used to validate a variety of
identification numbers, such as credit card numbers, IMEI numbers,
National Provider Identifier numbers in US and Canadian Social Insurance Numbers,
and even South African ID numbers.

It was created by IBM scientist Hans Peter Luhn and described in U.S. Patent
No. 2,950,048, filed on January 6, 1954, and granted on August 23, 1960.

## Copyright

Copyright (c) 2010 Joel Junström. See [LICENSE](LICENSE) for details.

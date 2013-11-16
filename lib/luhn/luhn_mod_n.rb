# Algorithm based on http://en.wikipedia.org/wiki/Luhn_mod_N_algorithm
module Luhn
  class LuhnModN
    def initialize(valid_characters)
      @valid_characters = valid_characters
    end

    def valid?(string_including_check_char)
      string = cleanup_string(string_including_check_char)
      chk_ch = string.slice!(-1)

      # assert the chk_ch
      raise_error_if_check_character_is_not_valid(chk_ch)

      check_character(string) == chk_ch
    end

    def generate(string_without_check_char)
      string_without_check_char + check_character(string_without_check_char)
    end

    def check_character(input_string)
      factor = 2;
      sum = 0;
      n = @valid_characters.size

      # Starting from the right and working leftwards is easier since
      # the initial "factor" will always be "2"
      input_string.reverse.each_char do |character|
        code_point = code_point_from_character(character)
        addend = factor * code_point

        # Alternate the "factor" that each "codePoint" is multiplied by
        factor = (factor == 2) ? 1 : 2

        # Sum the digits of the "addend" as expressed in base "n"
        addend = (addend / n) + (addend % n);
        sum += addend;
      end

      # Calculate the number that must be added to the "sum"
      # to make it divisible by "n"
      remainder = sum % n;
      check_code_point = (n - remainder) % n;

      character_from_code_point(check_code_point);
    end

    protected

    def raise_error_if_check_character_is_not_valid(chk_ch)
      code_point_from_character(chk_ch)
    end

    def code_point_from_character(ch)
      @valid_characters.index(ch) || raise("Unsupported character '#{ch}'")
    end

    def character_from_code_point(code_point)
      @valid_characters[code_point]
    end

    def cleanup_string(string)
      string.gsub(/\s/, '')
    end
  end
end
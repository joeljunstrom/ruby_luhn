require "thor"

class CLI < Thor 
  desc "calculate NUMBER", "calculate the luhn check digit of the number. In the interactive mode type exit to terminate"
  def calculate(number=nil)
    if number.nil?
      continue = true 
      while continue
        number = ask("number? ")
        if number.eql? "exit"
          continue = false
        end
        print_number number
      end      
    else
      print_number number
    end
  end
  
  desc "validate NUMBER", "validate the luhn check digit of the number. In the interactive mode type exit to terminate"
  def validate(number=nil)
    get_input_number(number) do |input_number|
      print_validity input_number
    end
  end
  
  private
  def get_input_number(number)
    if number.nil?
      continue = true 
      while continue
        number = ask("number? ")
        if number.eql? "exit"
          continue = false
        end
        yield number
      end      
    else
      yield number
    end
  end
  
  def print_validity(number)
    if is_number?(number)
      if Luhn.valid?(number)
        say "> " + number + "  correct"
      else
        say "> " + number + "  incorrect"
      end
    else
      say "> " + number + "  invalid number"
    end
  end
  
  def print_number(number)
    if is_number? number
      say "> " + number + Luhn.control_digit(number).to_s
    else
      say "> " + number + " is not a valid number"
    end    
  end
  
  def is_number?(number)
    if number.match(/\D/)
      false
    else
      true
    end
  end
end

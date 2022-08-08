require "date"
require_relative "./shift_calculator"
require_relative "./indexable"

class Enigma
  include Indexable
  attr_reader :characters,
              :shift_calculator

  def initialize
    @characters = ("a".."z").to_a << " "
    @shift_calculator = ShiftCalculator.new
  end

  def encrypt(message, key = @shift_calculator.key_generator, date = @shift_calculator.date_generator)
    encrypted_message = convert_to_encrypted_message(message, key, date)
    encryption = {
      :encryption => encrypted_message,
      :key => key,
      :date => date,
    }
  end

  def decrypt(message, key, date = @shift_calculator.date_generator)
    decrypted_message = convert_to_decrypted_message(message, key, date)
    decryption = {
      :decryption => decrypted_message,
      :key => key,
      :date => date,
    }
  end
end

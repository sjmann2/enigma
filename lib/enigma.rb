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
    message.downcase!
    encrypted_index_values = find_encrypted_index_values(message, key, date)

    encrypted_message = []
    encrypted_index_values.each do |position|
      if position.class == Array
        encrypted_message << position
      else
        encrypted_message << @characters[position]
      end
    end

    encryption = {
      :encryption => encrypted_message.join,
      :key => key,
      :date => date,
    }
  end

  def decrypt(message, key, date = @shift_calculator.date_generator)
    decrypted_index_values = find_decrypted_index_values(message, key, date)

    decrypted_message = []
    decrypted_index_values.each do |position|
      if position.class == Array
        decrypted_message << position
      else
        decrypted_message << @characters[position]
      end
    end

    decryption = {
      :decryption => decrypted_message.join,
      :key => key,
      :date => date,
    }
  end
end
